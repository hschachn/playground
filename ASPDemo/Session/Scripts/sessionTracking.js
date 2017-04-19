function activateSessionTracking(windowId) {

	var generateUuid = function () {
		var d = new Date().getTime();
		var uuid = "xxxxxxxxxxxx4xxxyxxxxxxxxxxxxxxx".replace(/[xy]/g, function (c) {
			var r = (d + Math.random() * 16) % 16 | 0;
			d = Math.floor(d / 16);
			return (c === "x" ? r : (r & 0x3 | 0x8)).toString(16);
		});
		return uuid;
	};


	$(document)
		.ready(
			function () {

				var browserSessionId = (function () {
					try {
						var mo = window.sessionStorage.getItem("browserSessionId");
						if (!mo) mo = generateUuid();
						window.sessionStorage.setItem("browserSessionId", mo);
						return mo;
					} catch (e) {
						return 0;
					}
				}());


				var duplicated = (function () {
					if ($("#duplicate").val() === "") {
						$("#duplicate").val("duplicated");		// Indikator
						return "";
					} else {
						// Event wird nicht aufgerufen bei "Duplicate"
						$(window).on("beforeunload", function () { $("#duplicate").val(""); });
						return "duplicated";
					}
				}());

				var trackingData = function (ajax) {

					if (ajax == null) {
						ajax = "false";
					} else {
						ajax = ajax ? "true" : "false";
					}

					var data = {
						BrowserSessionId: browserSessionId,
						WindowId: windowId,
						Duplicated: duplicated,
						Ajax: ajax
					};
					return btoa(JSON.stringify(data, null, 0));
				};

				// Add parameter to certain links, defined by class attribute
				$("a.session-tracking")
					.each(function (index) {

						// Pull native DOM element							
						var el = $(this)[0];

						var query = el.search; // Query string
						if (query === "")
							query += "?";
						else
							query += "&";

						query += "Tracking=" + trackingData();
						el.search = query;
					}
					);

				// Add parameter to ALL Forms ( or add special class?)
				$("form")
					.each(function () {
						$(this)
							.append($("<input>").attr("type", "hidden").attr("name", "Tracking").attr("id", "Tracking").val(trackingData()))
						;
					}
					);

				// Add default parameter to ALL Ajax calls
				$.ajaxSetup({
					data: {
						Tracking: trackingData(true)
					}
				});

				// Display tracking info 
				$("#displayTracking #browserSessionId").html(browserSessionId);
				$("#displayTracking #windowId").html(windowId);
				$("#displayTracking #duplicated").html(duplicated);

			});
};

