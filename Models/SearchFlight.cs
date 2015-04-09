using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel;

namespace MiniAirlineeservationSystem.Models
{
    public class SearchFlight
    {
        [Required(ErrorMessage = "Source field required")]
        public string Source { get; set; }

        public string Destination { get; set; }

        [Required(ErrorMessage = "Date of Journey required")]
        [DisplayName("Date of Journey : (Format : mm-dd-yyyy)")]
        public DateTime DateOfJourney { get; set; }

        
    }
}