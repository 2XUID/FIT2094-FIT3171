<html>
  <head>
    <title>Student List</title>
  </head>
  <body>
    <h1>Student list UNIVERSITY database</h1>

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
    <table border =1 width=650>
      <tr>
        <th width=100><b>Student ID</b></th>
        <th width=200><b>Name</b></th>
        <th width=150><b>Date of Birth</b></th>
        <th width=200><b>Email</b></th>
      </tr>

    <?php
      //SQL query statement
      $query = "SELECT
                studid,
                rtrim(studfname)
                || ' '
                || rtrim(studlname) AS sname,
                to_char(studdob, 'dd-Mon-yyyy') AS sbdate,
                studemail
                FROM
                    uni.student
                ORDER BY
                studid";

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
      oci_define_by_name($stmt,"STUDID",$studid);
      oci_define_by_name($stmt,"SNAME",$stuname);
      oci_define_by_name($stmt,"SBDATE",$stubdate);
      oci_define_by_name($stmt,"STUDEMAIL",$stuemail);

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
          <td width=100>$studid</td>
          <td width=200>$stuname</td>
          <td width=150>$stubdate</td>
          <td width=200>$stuemail</td>
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
  </body>
</html>

    
    
    