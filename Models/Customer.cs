using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.ComponentModel.DataAnnotations;

namespace MiniAirlineeservationSystem.Models
{
    public class Customer
    {
        public string FlightNo { get; set; }

        [Required]
        public string FirstName { get; set; }

        [Required]
        public string LastName { get; set; }

        [Required]
        public int Age { get; set; }

        public string SeatNo { get; set; }

        public DateTime DepartureDate { get; set; }

        public int Capacity { get; set; }

        public int CustomerId { get; set; }
    }
}