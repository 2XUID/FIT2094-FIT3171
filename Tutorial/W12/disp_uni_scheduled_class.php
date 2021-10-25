<html>
  <head>
    <title>Scheduled Lecture</title>
  </head>
  <body>
    <h1>Scheduled Lecture S1 2020 - UNIVERSITY database</h1>

    <?php
      // Set up the Oracle connection string
      $dbInstance = "(DESCRIPTION=(ADDRESS=(PROTOCOL=TCP)
      (HOST=ora-fit.ocio.monash.edu)(PORT=1521))
      (CONNECT_DATA=(SID=FITUGDB)))";

      // Connect to the database - Open Oracle connection
      $conn = oci_connect($_POST["username"], $_POST["password"], $dbInstance);
      if (!$conn) {
        $e = oci_error();
        print "Error connecting to the database:<br>" ;
        print $e['message'] ;
        exit;
      }
    ?>

    <!-- create HTML table header to display output -->
    <table border =1 width=800>
      <tr>
        <th width=450><b>UNIT</b></th>
        <th width=100><b>DAY</b></th>
        <th width=100><b>TIME</b></th>
        <th width=150><b>DURATION</b></th>
      </tr>

    <?php
      //SQL query statement
      $query = "";

      //Parse statement
      $stmt = oci_parse($conn,$query);
      if (!$stmt) {
        $e = oci_error($conn);
        print "Error on parse of statement:<br>" ;
        print $e['message'] ;
        exit;
      }
      // oci_define_by_name maps SQL Columns in a queryto PHP variable names
      // MUST be done before executing, Oracle names must be in UPPER case
      oci_define_by_name($stmt,"SNAME",$sname);
      oci_define_by_name($stmt,"SDAY",$sday);
      oci_define_by_name($stmt,"STIME",$stime);
      oci_define_by_name($stmt,"SDURATION",$sduration);
      oci_define_by_name($stmt,"STNAME",$stname);

      // Execute the STATEMENT
      $r = oci_execute($stmt);
      if (!$r) {
        $e = oci_error($stmt);
        print "Error execute of statement:<br>" ;
        print $e['message'] ;
        exit;
      }

      // Fetch the results of the query
      while (oci_fetch($stmt)) {
        print("
        <tr>
          <td width=450>
            <a href=\"#\" onclick= \"showStaff('Lecturer Name: " . $stname . "')\">
              $sname
            </a>
          </td>
          <td width=100>$sday</td>
          <td width=100>$stime</td>
          <td width=150>$sduration</td>
        </tr>");
      }
      // Close table
      print ("</table>");

      // Show the number of rows
      $no_rows = oci_num_rows($stmt);
      print "<p>Rows found:" . $no_rows . "</p>";

      // Free resources associated with Oracle statement
      oci_free_statement($stmt);
      // Close the Oracle connection
      oci_close($conn);
    ?>

    <!-- Java script to output message in a pop up window-->
    <script>
      function showStaff(message)
      {
        alert(message);
      }
    </script>

  </body>
</html>
