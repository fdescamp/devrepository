/// Summit Web Application 222
Class web.Application Extends %ZEN.application
{

/// This is the name of this application.
Parameter APPLICATIONNAME = "Summit Web Application";

/// This is the URL of the main starting page of this application.
Parameter HOMEPAGE;

/// This Style block contains application-wide CSS style definitions.
XData Style
{
<style type="text/css">
.portalTitle {
	width: 100%;
	height: 60px;
	position: relative;
	border-bottom: 1px solid gray;
	background: rgb(232,231,226);
	background: -webkit-gradient(linear, left top, left bottom, color-stop(0.0,rgb(232,231,226)), color-stop(0.5,rgb(242,241,236)), color-stop(1.0,rgb(232,231,226)));
	background: -moz-linear-gradient(top, rgb(232,231,226), rgb(242,241,236),rgb(222,221,216));
	background: linear-gradient(top, rgb(232,231,226), rgb(242,241,236),rgb(222,221,216));
}
body {
	background: rgb(232,231,226);
}
textarea.conflict {
	background: rgb(232,231,226);
	border:0;
	color:red;
}
.menuTable {
	height: 2.5em; 
	border: 0; 
	border-bottom: 1px solid black;
}
.screen {
	padding:1em;
}
.text {
	border: 1px solid black;
	padding:2px;
}
.dateTextDiv {
	border: 1px solid black;
}
.portalLogoBox {
	position: absolute;
	top: 0px;
	padding: 10px;
	padding-bottom: 4px;
	padding-right: 40px;
	right: 0px;
	text-align: center;
	background: rgb(232,231,226);
	background: -webkit-gradient(linear, left top, left bottom, color-stop(0.0,rgb(232,231,226)), color-stop(0.5,rgb(242,241,236)), color-stop(1.0,rgb(232,231,226)));
	background: -moz-linear-gradient(top, rgb(232,231,226), rgb(242,241,236),rgb(222,221,216));
	background: linear-gradient(top, rgb(232,231,226), rgb(242,241,236),rgb(222,221,216));
	z-index: 3;
}
.portalLogo {
	color: rgb(53,107,141);
	position: relative;
	font-weight: bold;
	font-size: 12pt;
	top: 0px;
	right: 0px;
	border: 2px solid rgb(53,107,141);
	padding: 2px;
	padding-left: 5px;
	padding-right: 5px;
	border-radius: 4px;
	background: #E0E0F0;
}
.portalLogoSub {
	position: relative;
	color: #808080;
	font-size: 8pt;
	top: 3px;
	right: 0px;
}
.portalTitleTabBox {
	position: absolute;
	color: white;
	font-size: 16px;
	bottom: 0px;
	left: 20px;
	width: 300px;
	height: 25px;
	padding-left: 15px;
	padding-right: 15px;
	padding: 5px;
	border-top-right-radius: 5px;
	border-top-left-radius: 5px;
	overflow: hidden;
	background: rgb(53,107,141);
	background: -webkit-gradient(linear, left top, left bottom, color-stop(0.0,rgb(53,107,141)), color-stop(1.0,rgb(23,77,101)));
	background: -moz-linear-gradient(top, rgb(53,107,141), rgb(23,77,101));
	background: linear-gradient(top, rgb(53,107,141), rgb(23,77,101));
	text-shadow: #F0F0F0 1px 1px 6px;
}
</style>
}

}
