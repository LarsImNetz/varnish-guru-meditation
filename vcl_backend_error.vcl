// Replacement for vcl_backend_error function for Varnish
// include this file of just copy this function into your default.vcl

sub vcl_backend_error {
    set beresp.http.Content-Type = "text/html; charset=utf-8";
    set beresp.http.Retry-After = "5";
    set beresp.body = {"<!DOCTYPE html>
<html>
<head>
<title>"} + beresp.status + " " + beresp.reason + {"</title>
</head>
<body>
<style>
.guru-meditation {
	border: black solid 8px;
	animation-name: example;
	animation-duration: 2s;
	animation-timing-function: step-start;
	animation-iteration-count: infinite;
	background-color: black;
	color: red;
}
@keyframes example {
	0%   {border-color: black;}
	50%  {border-color: red;}
	100% {border-color: black;}
}
.guru-meditation_text {
	padding-left: 4rem;
	padding-top: 0.25rem;
	padding-right: 4rem;
	padding-bottom: 0.25rem;
	line-height: 2.5rem;
	font-size: 16px;
	font-family: monospace;
	font-weight: normal;
}
</style>
<div class="guru-meditation">
  <div class="guru-meditation_text">
    <span style="float: left">Software Failure: "} + beresp.status + " " + beresp.reason + {".</span>
    <span style="float: right">Do not press left mouse button to continue.</span>
    <div style="clear: both;"></div>
    <div style="float: left">Guru Meditation:    XID: "} + bereq.xid + {"</div>
    <div style="float: right">Varnish cache server.</div>
    <div style="clear: both;"></div>
  </div>
</div>
</body>
</html>
"};
    return (deliver);
}