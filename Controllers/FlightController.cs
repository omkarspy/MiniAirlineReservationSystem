using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using System.Data.SqlClient;
using MiniAirlineeservationSystem.Models;
using System.Configuration;

namespace MiniAirlineeservationSystem.Controllers
{
    public class FlightController : Controller
    {
        private string connectionString = System.Configuration.ConfigurationManager.ConnectionStrings["OnlineAirlineReservation"].ConnectionString;
        private SqlCommand command;
        private string sql = null;
        
        /*
         * THIS ACTIONRESULT ALLOWS USER TO SEARCH FLIGHT BASED ON SOURCE AND DESTINATION
         */
        public ActionResult SearchFlight(String ErrMsg = "")
        {
            ViewData["ErrMsg"] = ErrMsg;
            return View();
        }

        /*
         * THIS ACTION RESULT SEARCHES CORRESPONDING FLIGHT REQUESTED BY USER AND DISPLAYS FLIGHT DETAILS TO THE USER
         */
        public ActionResult BookFlight(SearchFlight search)
        {
            if(!ModelState.IsValid)
            {
                return RedirectToAction("SearchFlight", new { ErrMsg = "Please enter Source and Date of Journey. Destination is optional."});
            }
            List<Flight> flights = new List<Flight>();
            string sql = "SELECT * FROM FLIGHT WHERE departure_airport LIKE '%" + search.Source
                                + "%' AND arrival_airport LIKE '%" + search.Destination
                                + "%' AND availability >= 1 AND departure_date = '" + search.DateOfJourney + "';";
            sql = String.Format(sql);  
            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                command = new SqlCommand(sql, connection);
                command.Connection.Open();
                var datareader = command.ExecuteReader();

                if (!datareader.HasRows)
                    return RedirectToAction("SearchFlight", new { ErrMsg = "No flights or seats available." });

                while (datareader.Read())
                {
                    flights.Add(new Flight()
                    {
                        FlightNo = datareader.GetValue(7).ToString(),
                        PriceFirstClass = (int)datareader.GetValue(1),
                        PriceEconomyClass = (int)datareader.GetValue(2),
                        DepartureAirport = datareader.GetValue(3).ToString(),
                        ArrivalAirport = datareader.GetValue(4).ToString(),
                        DepartureTime = (DateTime)datareader.GetValue(5),
                        ArrivalTime = (DateTime)datareader.GetValue(6),
                        DepartureDate = (DateTime)datareader.GetValue(9),
                        Availability = (int)datareader.GetValue(8)
                    });
                }
                connection.Close();
            }
            return View(flights);
        }

        /*
         * THIS ACTIONRESULT VALIDATES FOR CUSTOMER DETAILS WHILE ENTERING BOOKING DETAILS
         */
        public ActionResult CustomerDetails(Flight flight)
        {
            ViewData["ErrMsg"] = "Enter both the first name and last name.";
            return View(flight);
        }

        /*
         * THIS ACTIONRESULT DISPLAYS THE FLIGHT SELECTED BY USER WITH ITS DETAILS AND ALLOWS USER TO ENTER HIS DETAILS
         */
        [HttpPost]
        public ActionResult CustomerDetails()
        {
            Flight flight = new Flight();
            string flightNoDepartureDate = Request.Form["Book_FlightNo_Departure_Date"];
            string[] flightDetails = flightNoDepartureDate.Split(new char[]{','});
            string flightNo = flightDetails[0];
            DateTime departureDate = DateTime.Parse(flightDetails[1]);
            sql = "SELECT * FROM FLIGHT WHERE flight_no = '" + flightNo + "' and departure_date = '" + departureDate + "';";
            sql = String.Format(sql);  
            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                command = new SqlCommand(sql, connection);
                command.Connection.Open();
                var datareader = command.ExecuteReader();

                while (datareader.Read())
                {
                    flight.FlightNo = datareader.GetValue(7).ToString();
                    flight.PriceFirstClass = (int)datareader.GetValue(1);
                    flight.PriceEconomyClass = (int)datareader.GetValue(2);
                    flight.DepartureAirport = datareader.GetValue(3).ToString();
                    flight.ArrivalAirport = datareader.GetValue(4).ToString();
                    flight.DepartureTime = (DateTime)datareader.GetValue(5);
                    flight.ArrivalTime = (DateTime)datareader.GetValue(6);
                    flight.DepartureDate = (DateTime)datareader.GetValue(9);
                    flight.Availability = (int)datareader.GetValue(8);
                    flight.Capacity = (int)datareader.GetValue(0);
                }
                connection.Close();
            }
            return View(flight);
        }

        /*
         * THIS ACTION RESULT CHECKS FOR AVAILABILITY OF SEATS AND BOOKS THE FLIGHT FOR THE CUSTOMER...IT HANDLES MULTIPLE CLIENT TICKET BOOKING 
         * FOR THE LAST SEAT AVAILABLE (BONUS WORK POINT 4 IN THE SPECIFICATION)
         */
        public ActionResult BookingConfirmation()
        {
            string flightNo = Request.Form["Book_FlightNo"];
            string firstName = Request.Form["First_Name"];
            string lastName = Request.Form["Last_name"];
            int priceFirstClass = int.Parse(Request.Form["Price_First_Class"]);
            int priceEconomyClass = int.Parse(Request.Form["Price_Economy_Class"]);
            string departureAirport = Request.Form["Departure_Airport"];
            string arrivalAirport = Request.Form["Arrival_Airport"];
            DateTime departureTime = DateTime.Parse(Request.Form["Departure_Time"]);
            DateTime arrivalTime = DateTime.Parse(Request.Form["Arrival_Time"]);
            int availability = int.Parse(Request.Form["Availability"]);
            DateTime departureDate = DateTime.Parse(Request.Form["Departure_Date"]);
            int capacity = int.Parse(Request.Form["Capacity"]);
            int age = 0;
            int.TryParse(Request.Form["Age"], out age);

            if(firstName.Equals("") || lastName.Equals(""))
            {
                Flight flight = new Flight();
                flight.FlightNo = flightNo;
                flight.PriceFirstClass = priceFirstClass;
                flight.PriceEconomyClass = priceEconomyClass;
                flight.DepartureAirport = departureAirport;
                flight.ArrivalAirport = arrivalAirport;
                flight.DepartureTime = departureTime;
                flight.ArrivalTime = arrivalTime;
                flight.Availability = availability;
                flight.DepartureDate = departureDate;
                flight.Capacity = capacity;
                return RedirectToAction("CustomerDetails", flight);
            }

            //CHECK FOR AVAILABILITY
            sql = String.Format("SELECT * FROM FLIGHT WHERE flight_no = '" + flightNo + "' and departure_date = '" + departureDate + "' and availability >= 1;");
            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                command = new SqlCommand(sql, connection);
                command.Connection.Open();
                var datareader = command.ExecuteReader();
                if (!datareader.HasRows)
                {
                    connection.Close();
                    return RedirectToAction("SearchFlight", new { ErrMsg = "Sorry your booking could not be processed. No seats available as seat booked by other customer prior to your request." });
                }
                else
                {
                    sql = "UPDATE FLIGHT SET availability = availability - 1 WHERE flight_no = '" + flightNo + 
                            "' and departure_date = '" + departureDate + "';";
                    using (SqlConnection updateConnection = new SqlConnection(connectionString))
                    {
                        command = new SqlCommand(sql, updateConnection);
                        command.Connection.Open();
                        command.ExecuteNonQuery();
                        updateConnection.Close();
                    }
                    sql = "INSERT INTO CUSTOMER (flight_no, first_name, last_name, age, seat_no,departure_date, capacity) OUTPUT INSERTED.customer_id "  
                            + "VALUES('" + flightNo + "', '" + firstName + "', '" + lastName + "', " + age + 
                            ", '', '" + departureDate + "', " + capacity + ");";
                    int customerId = 0;
                    using (SqlConnection insertConnection = new SqlConnection(connectionString))
                    {
                        command = new SqlCommand(sql, insertConnection);
                        command.Connection.Open();
                        customerId = (int)command.ExecuteScalar();
                        insertConnection.Close();
                    }
                    Customer customer = new Customer();
                    customer.FlightNo = flightNo;
                    customer.FirstName = firstName;
                    customer.LastName = lastName;
                    customer.Age = age;
                    customer.DepartureDate = departureDate;
                    customer.Capacity = capacity;
                    customer.CustomerId = customerId;
                    ViewData["ErrMsg"] = "Congratulations!!! Flight Booked!!!";
                    return View(customer);
                }
            }
        }

        public ActionResult Index()
        {
            return View();
        }

        /*
         * THIS ACTION RESULT DISPLAYS ALL THE SEATS AVAILABLE TO THE CUSTOMER WHEN IT IS TIME TO BOOK SEATS AND TRIGGERS THE VIEW TO ALLOW USERS TO SELECT SEATS
         */
        public ActionResult SelectSeat()
        {
            string flightNo = Request.Form["Flight_No"];
            string firstName = Request.Form["First_Name"];
            string lastName = Request.Form["Last_Name"];
            int age = int.Parse(Request.Form["Age"]);
            string seatNo = Request.Form["Seat_No"];
            DateTime departureDate = DateTime.Parse(Request.Form["Departure_Date"]);
            int capacity = int.Parse(Request.Form["Capacity"]);
            int customerId = int.Parse(Request.Form["Customer_Id"]);
            
            List<Customer> customers = new List<Customer>();
            sql = "SELECT * FROM CUSTOMER WHERE flight_no = '" + flightNo + "' and departure_date = '" + departureDate + "';";
            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                command = new SqlCommand(sql, connection);
                command.Connection.Open();
                var datareader = command.ExecuteReader();

                while (datareader.Read())
                {
                    customers.Add(new Customer()
                    {
                        FlightNo = datareader.GetValue(0).ToString(),
                        FirstName = datareader.GetValue(1).ToString(),
                        LastName = datareader.GetValue(2).ToString(),
                        Age = (int)datareader.GetValue(3),
                        SeatNo = datareader.GetValue(4).ToString(),
                        DepartureDate = (DateTime)datareader.GetValue(5),
                        Capacity = (int)datareader.GetValue(6),
                        CustomerId = (int)datareader.GetValue(7)
                    });
                }
                connection.Close();
            }
            customers.Add(new Customer() 
            { 
                FlightNo = flightNo,
                FirstName = firstName,
                LastName = lastName,
                Age = age,
                SeatNo = seatNo,
                DepartureDate = departureDate,
                Capacity = capacity,
                CustomerId = customerId
            });
            return View(customers);
        }

        /*
         * THIS ACTION RESULT SHOWS THE DETAILS OF THE CUSTOMER ALONG WITH THE SEAT SELECTED...IT HANDLES MULTIPLE CLIENT TRYING
         * TO RESERVE THE SAME SEAT
         * 
         */
        public ActionResult BookingDetails()
        {
            string flightNo = Request.Form["Flight_No"];
            string firstName = Request.Form["First_Name"];
            string lastName = Request.Form["Last_Name"];
            DateTime departureDate = DateTime.Parse(Request.Form["Departure_date"]);
            int age = int.Parse(Request.Form["Age"]);
            string seatNo = Request.Form["Selected_Seat"];
            int capacity = int.Parse(Request.Form["Capacity"]);
            int customerId = int.Parse(Request.Form["Customer_Id"]);
            
            if (!(seatNo == null || seatNo.Equals("")))
            {
                sql = "SELECT * FROM CUSTOMER WHERE flight_no = '" + flightNo
                    + "' AND departure_date = '" + departureDate + "' AND seat_no = '" + seatNo
                    + "' AND first_name != '" + firstName + "' AND last_name != '" + lastName + "' AND customer_id != " + customerId + ";";
                using (SqlConnection outerConnection = new SqlConnection(connectionString))
                {
                    command = new SqlCommand(sql, outerConnection);
                    command.Connection.Open();
                    var datareader = command.ExecuteReader();
                    if (datareader.HasRows)
                    {
                        outerConnection.Close();
                        Customer customer = new Customer();
                        customer.FlightNo = flightNo;
                        customer.FirstName = firstName;
                        customer.LastName = lastName;
                        customer.Age = age;
                        customer.DepartureDate = departureDate;
                        customer.Capacity = capacity;
                        customer.CustomerId = customerId;
                        ViewData["ErrMsg"] = "We are sorry. This seat has been just booked. Try booking a different seat.";
                        return View("BookingConfirmation", customer);
                    }
                    else
                    {
                        sql = String.Format("UPDATE CUSTOMER SET seat_no = '" + seatNo + "' WHERE flight_no = '" + flightNo
                                    + "' AND first_name = '" + firstName + "' AND last_name = '" + lastName
                                    + "' AND departure_date = '" + departureDate + "' AND customer_id = " + customerId + ";");
                        using (SqlConnection connection = new SqlConnection(connectionString))
                        {
                            command = new SqlCommand(sql, connection);
                            command.Connection.Open();
                            command.ExecuteNonQuery();
                            connection.Close();
                        }
                        Customer customer = new Customer();
                        customer.FlightNo = flightNo;
                        customer.FirstName = firstName;
                        customer.LastName = lastName;
                        customer.Age = age;
                        customer.SeatNo = seatNo;
                        customer.DepartureDate = departureDate;
                        customer.Capacity = capacity;
                        customer.CustomerId = customerId;
                        ViewData["ErrMsg"] = "Congratulations!!! Seat Booked!!!";
                        return View("BookingConfirmation", customer);
                    }
                }
            }
            else
            {
                sql = "SELECT * FROM CUSTOMER WHERE customer_id = " + customerId + ";";
                Customer customer = new Customer();
                using (SqlConnection outerConnection = new SqlConnection(connectionString))
                {
                    command = new SqlCommand(sql, outerConnection);
                    command.Connection.Open();
                    var datareader = command.ExecuteReader();
                    while (datareader.Read())
                    {
                        customer.FlightNo = datareader.GetValue(0).ToString();
                        customer.FirstName = datareader.GetValue(1).ToString();
                        customer.LastName = datareader.GetValue(2).ToString();
                        customer.Age = (int)datareader.GetValue(3);
                        customer.SeatNo = datareader.GetValue(4).ToString();
                        customer.DepartureDate = (DateTime)datareader.GetValue(5);
                        customer.Capacity = (int)datareader.GetValue(6);
                        customer.CustomerId = (int)datareader.GetValue(7);
                    }
                }
                ViewData["ErrMsg"] = "No changes in seat have been made upon your blank request.";
                return View("BookingConfirmation", customer);
            }
        }

        public ActionResult CreateFlight()
        {
            return View();
        }

        /*
         * THIS ACTIONRESULT CREATES FLIGHT AN ALSO VALIDATES IF DETAILS ENTERED IN A WRONG MANNER BY SYSTEM ADMIN
         * 
         */
        [HttpPost]
        public ActionResult CreateFlight(Flight flight)
        {
            if(ModelState.IsValid)
            {
                if (DateTime.Compare(flight.DepartureTime, DateTime.Now) <= 0)
                {
                    ViewData["ErrMsg"] = "Departure date and time should be in future.";
                    return View();
                }
                if(flight.Capacity < flight.Availability)
                {
                    ViewData["ErrMsg"] = "Flight availability should be less than flight capacity.";
                    return View();
                }
                if (flight.PriceFirstClass <= flight.PriceEconomyClass)
                {
                    ViewData["ErrMsg"] = "First class ticket should be higher than economy class.";
                    return View();
                }
                if (flight.DepartureAirport.Equals(flight.ArrivalAirport))
                {
                    ViewData["ErrMsg"] = "Departure and arrival airport cannot be same.";
                    return View();
                }
                if(DateTime.Compare(flight.DepartureTime, flight.ArrivalTime) >= 0)
                {
                    ViewData["ErrMsg"] = "Departure time should be before arrival time.";
                    return View();
                }
                if(!flight.DepartureTime.Date.Equals(flight.DepartureDate.Date))
                {
                    ViewData["ErrMsg"] = "Departure date should be same as that entered in departure time.";
                    return View();
                }

                sql = "SELECT * FROM CUSTOMER WHERE flight_no = '" + flight.FlightNo + "' AND departure_date = '" + flight.DepartureDate + "';";
                Customer customer = new Customer();
                using (SqlConnection outerConnection = new SqlConnection(connectionString))
                {
                    command = new SqlCommand(sql, outerConnection);
                    command.Connection.Open();
                    var datareader = command.ExecuteReader();
                    if(datareader.HasRows)
                    {
                        ViewData["ErrMsg"] = "Only 1 flight with same flight number can fly each day.";
                        return View();
                    }
                }

                sql = String.Format("INSERT INTO Flight VALUES({0}, {1}, {2}, '{3}', '{4}', '{5}', '{6}', '{7}', {8}, '{9}');", flight.Capacity, flight.PriceFirstClass, flight.PriceEconomyClass, flight.DepartureAirport, flight.ArrivalAirport, flight.DepartureTime, flight.ArrivalTime, flight.FlightNo, flight.Availability, flight.DepartureDate);  //Request.Form["TextBox1"], Request.Form["TextBox2"]);
                using (SqlConnection connection = new SqlConnection(connectionString))
                {
                    command = new SqlCommand(sql, connection);
                    command.Connection.Open();
                    command.ExecuteNonQuery();
                    connection.Close();
                }
                return RedirectToAction("DisplayFlights");
            }
            return View();
        }

        /*
         * THIS ACTIONRESULT TRIGGERS DISPLAY FLIGHT VIEW FOR CUSTOMERS SO THAT THEY CAN SELECT FLIGHT FROM HERE AS WELL
         */
        public ActionResult Display()
        {
            List<Flight> flights = new List<Flight>();
            sql = "SELECT * FROM FLIGHT WHERE departure_time >= '" + DateTime.Now + "' AND availability >= 1;";
            sql = String.Format(sql);
            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                command = new SqlCommand(sql, connection);
                command.Connection.Open();
                var datareader = command.ExecuteReader();

                while (datareader.Read())
                {
                    flights.Add(new Flight()
                    {
                        Capacity = (int)datareader.GetValue(0),
                        PriceFirstClass = (int)datareader.GetValue(1),
                        PriceEconomyClass = (int)datareader.GetValue(2),
                        DepartureAirport = datareader.GetValue(3).ToString(),
                        ArrivalAirport = datareader.GetValue(4).ToString(),
                        DepartureTime = (DateTime)datareader.GetValue(5),
                        ArrivalTime = (DateTime)datareader.GetValue(6),
                        FlightNo = datareader.GetValue(7).ToString(),
                        DepartureDate = (DateTime)datareader.GetValue(9),
                        Availability = (int)datareader.GetValue(8)
                    });
                }
                connection.Close();
            }
            return View(flights);
        }
         
        /*
         * THIS ACTION RESULT DISPLAYS FLIGHTS AFTER THE SYSTEM ADMIN CREATES A NEW FLIGHT...IT IS ONLY VISIBLE TO SYSTEM ADMIN
         * 
         */
        public ActionResult DisplayFlights()
        {
            List<Flight> flights = new List<Flight>();
            sql = "SELECT * FROM FLIGHT WHERE departure_time >= '" + DateTime.Now + "' AND availability >= 1;";
            sql = String.Format(sql);
            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                command = new SqlCommand(sql, connection);
                command.Connection.Open();
                var datareader = command.ExecuteReader();

                while (datareader.Read())
                {
                    flights.Add(new Flight()
                    {
                        Capacity = (int)datareader.GetValue(0),
                        PriceFirstClass = (int)datareader.GetValue(1),
                        PriceEconomyClass = (int)datareader.GetValue(2),
                        DepartureAirport = datareader.GetValue(3).ToString(),
                        ArrivalAirport = datareader.GetValue(4).ToString(),
                        DepartureTime = (DateTime)datareader.GetValue(5),
                        ArrivalTime = (DateTime)datareader.GetValue(6),
                        FlightNo = datareader.GetValue(7).ToString(),
                        DepartureDate = (DateTime)datareader.GetValue(9),
                        Availability = (int)datareader.GetValue(8)
                    });
                }
                connection.Close();
            }
            return View(flights);
        }
    }
}
