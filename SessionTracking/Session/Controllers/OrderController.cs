using System;
using System.Web.Mvc;
using Session.Models;

namespace Session.Controllers
{
	[SessionTrackingFilter]
	public class OrderController : SessionTrackingController
	{
		// Beispiel : Link.
		public ActionResult Start() 
		{
			return View();
		}

		// Beispiel : Form
		public ActionResult CreateOrder(OrderViewModels order)
		{
			return View("Start");
		}

		// Beispiel : AJAX-Request. 
		[HttpPost]
		public ActionResult BackForth(String test) 
		{
			return new JsonResult();
		}
	}
}