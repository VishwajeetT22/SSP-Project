<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
        <%@ page import="java.sql.*"%>
      <%@ page import="java.io.*"%>
    <%//response.setContentType("application/vnd.ms-excel");
   // response.setHeader("Content-Disposition", "attachment;filename=ca2.xls");%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Insert title here</title>
</head>
<body>
<form action="CA1add.jsp">
<table border="1">
<tr>
<th colspan="3">Questions</th>
<th>CA2</th>
<%for(int i=1;i<=2;i++){%>
<th>Q<%=i %></th>
<th>Meet</th>
<%} %>
</tr>
<tr>
<th colspan="3">CO Mapped</th>
<th>Marks</th>
<th><%=request.getParameter("coname")%></th>
  <th>Y/N</th>
<th><%=request.getParameter("coname1") %>
</th>
 <th>Y/N</th>
</tr>
<tr>
<th>Sr No</th>
<th>Roll No</th>
<th>Name of student</th>
<th>10</th>
<th>5 Marks</th>
<th></th>
<th>5 Marks</th>
<th></th>
</tr>
<%
int year=Integer.parseInt(request.getParameter("year"));
String code=request.getParameter("code");

float pq1=0,pq2=0;
float avgm=0;
float avgq1=0 ;
float avgq2=0;
int lq1=0,lq2=0;
try {
	Class.forName("com.mysql.jdbc.Driver");  
	
	Connection connection=DriverManager.getConnection("jdbc:mysql://localhost:3306/copomapping","root","@Arjan196");
	Statement stmt=connection.createStatement(); 
	PreparedStatement stm=connection.prepareStatement("select ca2 from student where year=?");
	stm.setInt(1,year);
	ResultSet rs=stm.executeQuery();
	int j=0;
	
	 while(rs.next())
	 { 
	 j++;
	 int yes1=Integer.parseInt(request.getParameter("q1marks"+j));
	 int yes2=Integer.parseInt(request.getParameter("q2marks"+j));
	 
	 avgm=avgm+rs.getInt(1);
	 avgq1=avgq1+yes1;
	 avgq2=avgq2+yes2;
	 }
	 avgm=avgm/j;
	 avgq1=avgq1/j;
	avgq2=avgq2/j;
	pq1=(avgq1*100)/5;
	pq2=(avgq2*100)/5;
}
catch (SQLException e) {
	
	e.printStackTrace();
} catch (ClassNotFoundException e) {

	e.printStackTrace();
}
%>
<%
try {
	Class.forName("com.mysql.jdbc.Driver");  
	
	Connection connection=DriverManager.getConnection("jdbc:mysql://localhost:3306/copomapping","root","@Arjan196");
	Statement stmt=connection.createStatement(); 
	PreparedStatement stm=connection.prepareStatement("select prn,name,ca2 from student where year=?");
	stm.setInt(1,year);
	ResultSet rs=stm.executeQuery();
	int j=0;
	int ycoq1=0;
	int ncoq1=0;
	int ycoq2=0;
	int ncoq2=0;
	
 while(rs.next())
 { 
 j++;
 int yes1=Integer.parseInt(request.getParameter("q1marks"+j));
 int yes2=Integer.parseInt(request.getParameter("q2marks"+j));

 String yesq1="";
 String yesq2="";
 if(yes1>=avgq1)
 {
	yesq1="Y";
	ycoq1++;
 }
 else
 {
	 yesq1="N";
	 ncoq1++;
 }
 if(yes2>=avgq2)
 {
	 yesq2="Y";
	 ycoq2++;
	 
 }
 else
 {
	 yesq2="N";
	 ncoq2++;
 }
 

 
 %>	
<tr>
<td><%=j %></td>
<td><%=rs.getString(1) %></td>
<td><%=rs.getString(2) %></td>
<td><%=rs.getInt(3) %></td>
<td><%=yes1 %></td>
<td><%=yesq1 %></td>
<td><%=yes2 %></td>
<td><%=yesq2 %></td>
</tr>

<%
 }

if(pq1>70)
{
	lq1=3;
}
else if(pq1>50&&pq1<=70)
{
	lq1=2;
}
else
{
	lq1=1;
}
if(pq2>70)
{
	lq2=3;
}
else if(pq2>50&&pq2<=70)
{
	lq2=2;
}
else
{
	lq2=1;
}

 %>
 <tr>
 <th colspan="3">Average</th>
 <td><%=avgm %></td>
 <td><%=avgq1 %></td>
 <td></td>
 <td><%=avgq2 %></td>
 <td></td>
 </tr>
 </table>
 
 <br><br>
<table border=1>
<tr>
<th>Count</th>
<th>Q1</th>
<th>Q2</th>
</tr>
<tr>
<td>Y</td>
<td><%=ycoq1 %></td>
<td><%=ycoq2 %></td>
</tr>
<tr>
<td>N</td>
<td><%=ncoq1 %></td>
<td><%=ncoq2 %></td>
</tr>
</table>
 <br><br>
 
 
 <table border=1>
 <tr>
 <th>CO</th>
 <th>No of questions Mapped</th>
 <th>Class Average</th>
 <th>Class Percentage</th>
 <th>CO Mapped to Level</th>
 </tr>
 <tr>
 <td><%=request.getParameter("coname")%></td>
 <td>1</td>
 <td><%=avgq1 %></td>
 <td><%=pq1 %></td>
 <td><%=lq1 %></td>
 </tr>
 <tr>
 <td><%=request.getParameter("coname1")%></td>
 <td>1</td>
 <td><%=avgq2 %></td>
 <td><%=pq2 %></td>
 <td><%=lq2 %></td>
 
 </tr>
 
 
 </table>
 <br><br>
 <%
}
 catch (SQLException e) {
	
	e.printStackTrace();
} catch (ClassNotFoundException e) {

	e.printStackTrace();
}
%>
<%
try {
	Class.forName("com.mysql.jdbc.Driver");  
	int i1=1,i2=0;
	Connection connection=DriverManager.getConnection("jdbc:mysql://localhost:3306/copomapping","root","@Arjan196");
	Statement stmt=connection.createStatement(); 
	PreparedStatement stm=connection.prepareStatement("insert into ca2 values(?,?,?,?,?)");
	String q1=(request.getParameter("coname"));
	String q2=(request.getParameter("coname1"));
	stm.setString(1,q1);
	stm.setString(2,q2);
	stm.setInt(3,lq1);
	stm.setInt(4,lq2);
	stm.setString(5,code);
	stm.execute();
	
}
catch (SQLException e) {
	
	e.printStackTrace();
} catch (ClassNotFoundException e) {

	e.printStackTrace();
}
%>
</form>
</body>
</html>