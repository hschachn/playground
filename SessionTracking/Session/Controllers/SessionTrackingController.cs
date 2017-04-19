using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.Linq;
using System.Reflection;
using System.Text;
using System.Web;
using System.Web.Mvc;
using Newtonsoft.Json;

namespace Session.Controllers
{

	internal class TrackingData
	{
		// Nur String-Parameter erlaubt
		public String BrowserSessionId { get; set; }		// Auftrags ( = Browser) -Session
		public String WindowId { get; set; }				// Eindeutige Id des aufrufenden Browser-Fensters
		public String Duplicated { get; set; }				// Zeigt an, ob das Fenster dupliziert worden ist.
		public String Ajax { get; set; }						// Kennzeichnet asynchrone Aufrufe	
	
		public TrackingData()
		{
			BrowserSessionId = "";
			WindowId = "";
			Duplicated = "";
			Ajax = "";
		}
	}

	public class SessionTracking
	{
		// TODO: Um OrderId erweitern

		private readonly TrackingData _trackingData;

		public Boolean IsDuplicate
		{
			get { return !String.IsNullOrEmpty(_trackingData.Duplicated); }
		}

		public Boolean IsAjax
		{
			get
			{
				return _trackingData.Ajax != null && _trackingData.Ajax.ToLower().Equals("true");
			}
		}

		public SessionTracking (ActionExecutingContext filterContext) 
		{
			try
			{
				var encodedTrackingData = ExtractParameter(filterContext, "Tracking");
				if (encodedTrackingData == null) return;

				var jsonBack = Encoding.UTF8.GetString(Convert.FromBase64String(encodedTrackingData));
				_trackingData = JsonConvert.DeserializeObject<TrackingData>(jsonBack);
			}
			catch (Exception)
			{
				; // Intenionally left blank
			}

		}

		private static String ExtractParameter(ActionExecutingContext filterContext, String attributeName)
		{
			var attributeValue = "";
			// Im Normalfall muss der Wert aus den URL-Parametern ermittelt werden, damit
			// nicht die Signaturen alle Action-Methoden angepasst werden müssen.
			if (
				filterContext.ActionParameters == null ||
				filterContext.ActionParameters.Count == 0 ||
				!filterContext.ActionParameters.ContainsKey(attributeName))
			{
				try
				{
					attributeValue = filterContext.HttpContext.Request.Params[attributeName];
				}
				catch (KeyNotFoundException)
				{
					; // Intentionally left blank
				}
			}

			if (!String.IsNullOrEmpty(attributeValue)) return attributeValue;

			try
			{
				if (filterContext.ActionParameters != null)
				{
					var actionParameter = filterContext.ActionParameters[attributeName];
					if (actionParameter != null)
						attributeValue = actionParameter.ToString();
				}
			}
			catch (KeyNotFoundException)
			{
				; // Intentionally left blank
			}
			return attributeValue;
		}

		public static MvcHtmlString Activate()
		{
			var windowId = Guid.NewGuid().ToString("N");
			return new MvcHtmlString(@"<script type='text/javascript'>activateSessionTracking('" + windowId + "');</script>");
		}

		public static MvcHtmlString Anchor()
		{
			return new MvcHtmlString(@"
<form name='ignore_me' style='visibility: hidden;'>
	<input type='text' id='duplicate' name='duplicate' value=''/>
</form>
");
		}
	}

	// Basisklasse für alle Controller mit SessionTracking
	public class SessionTrackingController : Controller
	{
		private const String SessionTrackingList = "TrackingList";

		private LinkedList<SessionTracking> WindowList
		{
			get
			{
				if (Session[SessionTrackingList] == null)
					Session[SessionTrackingList] = new LinkedList<SessionTracking>();

				return (LinkedList<SessionTracking>)Session[SessionTrackingList];
			}
		}

		// TODO: Status setzen, der anzeigt, ob 
		// 1. Das Fenster schon mal besucht war (Zurück, Vor , Duplizieren)
		// 2. Zu einem (gespeicherten) Auftrag mehrere Fenster offen sind.
		// etc.

		// Aufruf registrieren und Tracking Daten speichern.
		public static void Register(ActionExecutingContext filterContext)
		{
			var controller = (SessionTrackingController)filterContext.Controller;
			if (controller == null) return;

			controller.WindowList.AddLast(new SessionTracking(filterContext));

			 // Browsername filterContext.HttpContext.Request.Browser.Browser
			;

			Debug.WriteLine(filterContext.HttpContext.Request.UserHostAddress);
		}
	}
}