using System;
using System.Data;
using System.IO;
using System.Data.OleDb;
using System.Configuration;
using System.Data.SqlClient;

public partial class TOPLog_UploadTest2 : System.Web.UI.Page
{
    
    OleDbConnection Econ;  
    SqlConnection con;  
  
    string constr,Query,sqlconn;  
    protected void Page_Load(object sender, EventArgs e)  
    {  
  
  
    }  
  
    private void ExcelConn(string FilePath)  
    {  
  
        constr = string.Format(@"Provider=Microsoft.Jet.OLEDB.4.0;Data Source={0};Extended Properties=""=Excel 8.0;Persist Security Info=False;""", FilePath);  
        Econ = new OleDbConnection(constr);  
       
    }  
    private void connection()  
    {
        sqlconn = ConfigurationManager.ConnectionStrings["TOPLogConnectionString"].ConnectionString;  
        con = new SqlConnection(sqlconn);  
      
    }  
    
  
    private void InsertExcelRecords(string FilePath)  
    {  
        ExcelConn(FilePath);  
  
        Query = string.Format("Select [Name],[City],[Address],[Designation] FROM [{0}]", "Sheet1$");  
        OleDbCommand Ecom = new OleDbCommand(Query, Econ);  
        Econ.Open();  
  
            DataSet ds=new DataSet();  
            OleDbDataAdapter oda = new OleDbDataAdapter(Query, Econ);  
            Econ.Close();  
            oda.Fill(ds);  
            DataTable Exceldt = ds.Tables[0];  
       connection();  
       //creating object of SqlBulkCopy    
       SqlBulkCopy objbulk = new SqlBulkCopy(con);  
       //assigning Destination table name    
       objbulk.DestinationTableName = "Employee";  
       //Mapping Table column    
       objbulk.ColumnMappings.Add("Name", "Name");  
       objbulk.ColumnMappings.Add("City", "City");  
       objbulk.ColumnMappings.Add("Address", "Address");  
       objbulk.ColumnMappings.Add("Designation", "Designation");  
       //inserting Datatable Records to DataBase    
       con.Open();  
       objbulk.WriteToServer(Exceldt);  
       con.Close();  
  
    }  
    protected void Button1_Click(object sender, EventArgs e)  
    {    
        string CurrentFilePath = Path.GetFullPath(FileUpload1.PostedFile.FileName);  
        InsertExcelRecords(CurrentFilePath);  
    }  
}  