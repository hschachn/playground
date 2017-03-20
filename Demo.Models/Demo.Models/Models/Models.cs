using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Demo.Models.Models
{
	public class PersonModel
	{
		public string FirstName { get; set; }
		public string LastName { get; set; }
	}

	public class EmployedPersonModel : PersonModel
	{
		public int WorkerId { get; set; }
	}

	public class StudendModel : PersonModel
	{
		public int StudentId { get; set; }
	}


	public class EmployedPersonViewModel
	{
		public EmployedPersonModel Person { get; set; }

		public string PageTitle { get; set; }

	}

	public class StudentPersonViewModel
	{
		public StudendModel Person { get; set; }

		public string PageTitle { get; set; }

	}
}