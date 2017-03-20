using Demo.Models.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace Demo.Models.Controllers
{
	public class HomeController : Controller
	{
		public ActionResult Index()
		{
			return View();
		}

		public ActionResult About()
		{
			ViewBag.Message = "Your application description page.";

			return View();
		}

		public ActionResult Contact()
		{
			ViewBag.Message = "Your contact page.";

			return View();
		}

		public ActionResult Employed()
		{
			var vm = new EmployedPersonViewModel { PageTitle = "Employed..." };
			return View(vm);
		}

		[HttpPost]
		public ActionResult Employed(EmployedPersonViewModel model)
		{
			var i = 0;
			return View();
		}


		public ActionResult Student()
		{
			var vm = new StudentPersonViewModel { PageTitle = "Student..." };
			return View(vm);
		}

		[HttpPost]
		public ActionResult Student(StudentPersonViewModel model)
		{
			var i = 0;
			return View();
		}
	}
}