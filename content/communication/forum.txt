<?
header('Content-Type: text/html; charset=UTF-8');
if (!ereg('^[0-9]{4,4}-[0-9]{1,2}$',$_GET['ym'])) { $_GET['ym'] = '2002-01'; }
$waarden = explode('-',$_GET['ym']);
$m = $waarden[1];
$y = $waarden[0];

//mysql_connect('', '', '');
mysql_select_db('13253drc');
if (strlen($m)==1)
{
	$month = '0'.$m;
	$year = $y;
	if ($m!=9) {$next = '0'.(intval($m)+1);}
	else {$next = (intval($m)+1);}
}
else
{
	$year = $y;
	$month = $m;
	if ($m!=12) {$next = (intval($m)+1);}else{$next='01';$year=$year+1;}
}
$begin = strtotime($y.$month.'01');
$eind = strtotime( $year.$next.'01');

$sql = 'SELECT * FROM topics WHERE date >= '.$begin.' AND date < '.$eind.' ORDER BY date ASC';
$result = mysql_query($sql) or die(mysql_error());
$forum = $y;
?>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01//EN" "http://www.w3.org/TR/html4/strict.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<title>D&#8217;ni Restoration Archive - DRC forum dicussions</title>
<link rel="stylesheet" href="/assets/style.css" type="text/css" media="screen">
<link rel="stylesheet" href="/assets/style_print.css" type="text/css" media="print">
</head>

<body>

<div id="header">
	<h1>D&#8217;ni Restoration Archive</h1>
</div>

<div id="menu">
	<ul>
	<li><a href="/">Home</a></li>
	<li><a href="/restoration/">Restoration Progress</a></li>
	<li><a href="/documents/">Documents</a></li>
	<li id="actief"><a href="/communication/">Communication</a></li>
	</ul>
</div>

<div id="pagina">

<div class="breadcrumbs">
You are here: <a href="/communication/">Communication</a> &raquo; <a href="/communication/forum/">DRC forum discussions</a>
</div>

<h2>DRC forum discussions</h2>
<form action="/communication/forum/" method="get">
<p>
<select name="ym">
<optgroup label="2002">
<option value="2002-1">January</option>
<option value="2002-4">April</option>
<option value="2002-5">May</option>
<option value="2002-6">June</option>
<option value="2002-7">July</option>
<option value="2002-8">August</option>
<option value="2002-9">September</option>
<option value="2002-10">October</option>
<option value="2002-11">November</option>
<option value="2002-12">December</option>
</optgroup>
<optgroup label="2003">
<option value="2003-1">January</option>
<option value="2003-4">April</option>
<option value="2003-7">July</option>
<option value="2003-9">September</option>
<option value="2003-10">October</option>
<option value="2003-11">November</option>
<option value="2003-12">December</option>
</optgroup>
<optgroup label="2004">
<option value="2004-1">January</option>
<option value="2004-2">February</option>
</optgroup>
<optgroup label="2005">
<option value="2005-12">December</option>
</optgroup>
<optgroup label="2006">
<option value="2006-1">January</option>
<option value="2006-2">February</option>
<option value="2006-6">June</option>
<option value="2006-12">December</option>
</optgroup>
<optgroup label="2007">
<option value="2007-2">February</option>
<option value="2007-4">April</option>
</optgroup>
</select>
<input type="submit" value="Go!" />
</p>
</form>
<h3><? echo date("F",$begin); ?>, <? echo $y; ?></h3>
<ul>
<?
$rij = array();
while($row = mysql_fetch_array($result))
{
	$rij[$row['id']] = $row['title'];
	echo "<li><a href=\"#".$row['id']."\">{$row['title']}</a></li>";
}
echo "</ul>";
foreach($rij as $id => $title)
{
	echo "<a name=\"$id\"></a><h3>$title</h3><div class=\"article\">";
	$sql = "SELECT * FROM posts WHERE topic_id = $id ORDER BY date ASC";
	$result = mysql_query($sql) or die(mysql_error());
	$j=0;
	while($row = mysql_fetch_array($result))
	{
		$j++;
		if ($j!=1) {echo "<hr />";}
		echo '<p><strong>'.$row['author'].' - '.date("F d, Y",$row['date']).'</strong></p>'.$row['post'];
	}
	echo "</div>";
}
?>

</div>

<div id="copyright">	
<p>
All Myst, Riven and D'ni images and text &copy; Cyan Worlds, Inc. All rights reserved.<br>
No part may be copied or reproduced without express, written permission of Cyan Worlds, Inc.<br>
Assets used with permission.
</p>
</div>

</body>
</html>