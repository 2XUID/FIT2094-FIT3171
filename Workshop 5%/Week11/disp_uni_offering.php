<html>
  <head>
    <title>Offering List</title>
  </head>
  <body>
    <h1>Offering list UNIVERSITY database</h1>

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
        <th width=100><b>Unit Code</b></th>
        <th width=400><b>Unit Name</b></th>
        <th width=150><b>Semester and Year</b></th>
        <th width=150><b>Chief Examiner</b></th>
      </tr>

    <?php
      //SQL query statement, do not include ;
      $query = "SELECT u.unitcode as ucode, unitname as uname, 'S'||semester || ' ' || to_char(ofyear,'yyyy') as syear,
       rtrim(stafffname) || ' ' || rtrim(stafflname) as stname
       FROM uni.unit u join uni.offering o on u.unitcode = o.unitcode
       join uni.staff st on o.chiefexam = st.staffid
       ORDER BY ucode";

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
      oci_define_by_name($stmt,"UCODE",$uncode);
      oci_define_by_name($stmt,"UNAME",$unname);
      oci_define_by_name($stmt,"SYEAR",$semyear);
      oci_define_by_name($stmt,"STNAME",$cename);

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
          <td width=100>$uncode</td>
          <td width=400>$unname</td>
          <td width=150>$semyear</td>
          <td width=150>$cename</td>
          </tr>");
      }

      // Close table
      print ("</table>");

      $no_rows = oci_num_rows($stmt);
      print "<p>Rows found:" . $no_rows . "</p>";

      // Free resources associated with Oracle statement
      oci_free_statement($stmt);
      // Close the Oracle connection
      oci_close($conn);

    ?>
    </body>
</html>
