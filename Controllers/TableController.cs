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
    public class TableController : Controller
    {
        //
        // GET: /Table/
        public ActionResult CreateTable()
        {
            return View();
        }
        public ActionResult Index()
        {
            return View();
        }

        //
        // GET: /Table/Details/5

        public ActionResult Details(int id)
        {
            return View();
        }

        //
        // GET: /Table/Create

        public ActionResult Create()
        {
            return View();
        } 

        //
        // POST: /Table/Create
        
        [HttpPost]
        public ActionResult Create(Table query)
        {
            try
            {
                // TODO: Add insert logic here

                string connectionString = null;
                SqlCommand command;
                string sql = null;

                connectionString = System.Configuration.ConfigurationManager.ConnectionStrings["AirlineReservation"].ConnectionString;
                sql = "" + Request.Form["Query"];
                //sql = String.Format(query.Query);
                using (SqlConnection connection = new SqlConnection(connectionString))
                {
                    //connection.Open();
                    command = new SqlCommand(sql, connection);
                    command.Connection.Open();
                    command.ExecuteNonQuery();
                    connection.Close();
                }
                return RedirectToAction("CreateTable");
            }
            catch
            {
                return View();
            }
        }
        
        //
        // GET: /Table/Edit/5
 
        public ActionResult Edit(int id)
        {
            return View();
        }

        //
        // POST: /Table/Edit/5

        [HttpPost]
        public ActionResult Edit(int id, FormCollection collection)
        {
            try
            {
                // TODO: Add update logic here
 
                return RedirectToAction("Index");
            }
            catch
            {
                return View();
            }
        }

        //
        // GET: /Table/Delete/5
 
        public ActionResult Delete(int id)
        {
            return View();
        }

        //
        // POST: /Table/Delete/5

        [HttpPost]
        public ActionResult Delete(int id, FormCollection collection)
        {
            try
            {
                // TODO: Add delete logic here
 
                return RedirectToAction("Index");
            }
            catch
            {
                return View();
            }
        }
    }
}
