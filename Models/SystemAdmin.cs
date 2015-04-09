using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.ComponentModel.DataAnnotations;

namespace MiniAirlineeservationSystem.Models
{
    public class SystemAdmin
    {
        [Required(ErrorMessage = "Username required")]
        public String UserName { get; set; }

        [Required(ErrorMessage = "Password required")]
        public String Password { get; set; }

    }
}