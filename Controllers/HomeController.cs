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
    [HandleError]
    public class HomeController : Controller
    {
        private string connectionString = System.Configuration.ConfigurationManager.ConnectionStrings["OnlineAirlineReservation"].ConnectionString;
        private SqlCommand command;
        private string sql = null;

        /*
         * THIS ACTIONRESULT SPECIFIES THE WELCOME MESSAGE 
         * 
         */
        public ActionResult Index()
        {
            ViewData["Message"] = "Welcome to Online Airline Reservation System!!!";

            return View();
        }

        /*
         * THIS ACTIONRESULT ALLOWS THE NEW USER TO REGISTER AND BECOME AN ADMIN 
         */
        public ActionResult Admin()
        {
            return View();
        }


        /*
         * THIS ACTION RESULT VALIDATES AND STORES THE INFO OF REGISTERED USER IN A TABLE NAMED SYSTEMADMIN 
         * 
         */
        [HttpPost] 
        public ActionResult Admin(SystemAdmin admin)
         {
            if(!ModelState.IsValid)
            {
                ViewData["ErrMsg"] = "Please enter both username and password.";
                return View();
            }
            
            sql = String.Format("SELECT * FROM SYSTEMADMIN WHERE username = '" + admin.UserName + "' OR password = '" + admin.Password + "';");  
            using (SqlConnection usernameConnection = new SqlConnection(connectionString))
            {
                command = new SqlCommand(sql, usernameConnection);
                command.Connection.Open();
                var datareader = command.ExecuteReader();
                if(datareader.HasRows)
                {
                    ViewData["ErrMsg"] = "Please select a different combination of username and password. Username and/or password already exists.";
                    return View();
                }
                usernameConnection.Close();
            }

            sql = String.Format("INSERT INTO SystemAdmin VALUES('{0}', '{1}');", admin.UserName, admin.Password);  
            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                command = new SqlCommand(sql, connection);
                command.Connection.Open();
                command.ExecuteNonQuery();
                connection.Close();
            }
            return RedirectToAction("CreateFlight", "Flight");
        }

        /*
         *  THIS ACTIONRESULT ALLOWS USERS/SYSTEM ADMINS TO SIGN IN AND CREATE FLIGHT
         */
        public ActionResult SignIn()
        {
            return View();
        }

        /*
         * THIS ACTIONRESULT VALIDATES SIGN IN FUNCTIONALITY AND ALLOWS USER TO CREATE FLIGHT BY REDIRECTING IT TO CREATE FLIGHT PAGE
         * 
         */
        [HttpPost]
        public ActionResult SignIn(SystemAdmin admin)
        {
            if (!ModelState.IsValid)
            {
                ViewData["ErrMsg"] = "All the fields are required. Please enter both username and password.";
                return View();
            }

            sql = String.Format("SELECT * FROM SystemAdmin where username = '" + admin.UserName + "' AND password = '" + admin.Password + "';");  //Request.Form["TextBox1"], Request.Form["TextBox2"]);
            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                command = new SqlCommand(sql, connection);
                command.Connection.Open();
                var datareader = command.ExecuteReader();
                if (!datareader.HasRows)
                {
                    ViewData["ErrMsg"] = "Invalid username and password. Try again";
                    return View();
                }
                else 
                {
                    connection.Close();
                    return RedirectToAction("CreateFlight", "Flight");
                }
            }
        }

        /*
         * THIS ACTIONRESULT DISPLAYS ALL THE FLIGHTS AVAILABLE
         */
        public ActionResult DisplayFlights()
        {
            return View();
        }

        /*
         * THIS ACTONRESULT ALLOWS USER TO CREATE FLIGHT
         */
        public ActionResult CreateFlight() 
        {
            return View();
        }

        /*
         * THIS ACTIONRESULT ALLOWS USER TO BECOME A SYSTEM ADMIN
         */
        public ActionResult CreateAdmin()
        {
            return View();
        }

        public ActionResult Template()
        {
            return View();    
        }
    }
}
