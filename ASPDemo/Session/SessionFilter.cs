using System.Web.Mvc;
using Session.Controllers;

namespace Session
{
	public class SessionTrackingFilter : ActionFilterAttribute
	{
		public override void OnActionExecuting(ActionExecutingContext filterContext)
		{			
			SessionTrackingController.Register(filterContext);
		}
	}
}