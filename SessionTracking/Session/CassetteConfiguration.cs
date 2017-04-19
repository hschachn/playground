using Cassette;
using Cassette.Scripts;
using Cassette.Stylesheets;

namespace Session
{
    /// <summary>
    /// Configures the Cassette asset bundles for the web application.
    /// </summary>
    public class CassetteBundleConfiguration : IConfiguration<BundleCollection>
    {
        public void Configure(BundleCollection bundles)
        {
            // TODO: Configure your bundles here...cripts/sessionStorage.js");
				bundles.Add<ScriptBundle>("jquery", "Scripts/jquery-1.10.2.min.js");
        }
    }
}