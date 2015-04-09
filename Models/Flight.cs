using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.ComponentModel.DataAnnotations;

namespace MiniAirlineeservationSystem.Models
{
    public class Flight
    {
        [Required(ErrorMessage = "Capacity required")]
        public int Capacity { get; set; }

        [Required(ErrorMessage = "Price required")]
        public int PriceFirstClass { get; set; }

        [Required(ErrorMessage = "Price required")]
        public int PriceEconomyClass { get; set; }

        [Required(ErrorMessage = "Departure airport required")]
        public string DepartureAirport { get; set; }

        [Required(ErrorMessage = "Arrival airport required")]
        public string ArrivalAirport { get; set; }

        [Required(ErrorMessage = "Departure time required")]
        public DateTime DepartureTime { get; set; }

        [Required(ErrorMessage = "Arrival time required")]
        public DateTime ArrivalTime { get; set; }

        [Required(ErrorMessage = "Flight no required")]
        public string FlightNo { get; set; }

        [Required(ErrorMessage = "Availability required")]
        public int Availability { get; set; }

        [Required(ErrorMessage = "Departure Date required")]
        public DateTime DepartureDate { get; set; }

    }
}