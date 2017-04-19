using System;
using System.Linq.Expressions;
using System.Web.Mvc;
using System.Web.Mvc.Html;
using Cassette;
using Cassette.Scripts;
using Microsoft.Owin;
using Owin;
using Session.Models;

[assembly: OwinStartup(typeof(Session.Startup))]

namespace Session
{

	public static class HtmlHelperExtensions
	{
	}

	public class CassetteConfiguration : IConfiguration<BundleCollection>
	{
		public void Configure(BundleCollection bundles)
		{
			bundles.Add<ScriptBundle>("session", "Scripts/sessionTracking.js");
		}
	}

    public partial class Startup	
    {
        public void Configuration(IAppBuilder app)
        {
            ConfigureAuth(app);
        }
    }


}
