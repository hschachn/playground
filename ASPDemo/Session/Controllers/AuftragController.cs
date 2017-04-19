using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web.Http;
using System.Web.Mvc;
using Session.Controllers;

namespace Session.Controllers
{
	public class OrderData
	{
		public String Name { get; set; }
		public Int32 OrderNumber { get; set; }
	}

	public class AuftragController : ApiController
	{
		[System.Web.Http.HttpGet]
		public OrderData ReadData()
		{
			return new OrderData { Name = "Bert", OrderNumber = 656731 };
		}
	}
}
