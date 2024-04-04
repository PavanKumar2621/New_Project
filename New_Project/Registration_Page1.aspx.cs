using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Globalization;
using System.Linq;
using System.Net;
using System.Reflection.Emit;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace New_Project
{
    public partial class Registration_Page1 : System.Web.UI.Page
    {
        SqlConnection con;
        SqlCommand cmd;
        SqlDataReader dr;
        SqlDataAdapter da;
        DataSet ds;
        string state;
        string datepart;
        string gender;
        protected void Page_Load(object sender, EventArgs e)
        {
            con = new SqlConnection("Data Source = DESKTOP-344D91U\\SQLEXPRESS; Initial Catalog=Demo; Integrated Security=True");
            if (!IsPostBack)
                showdata();
            
        }
        public void showdata()
        {
            da = new SqlDataAdapter("select sno,name,Designation,joining_date,Salary,Gender,State from Emp order by sno", con);
            ds = new DataSet();
            da.Fill(ds, "Emp");

            GridView1.DataSource = ds.Tables["Emp"];
            GridView1.DataBind();
        }

        protected void btnSubmit_Click(object sender, EventArgs e)
        {

            //code for gender
            GetGender();

            //code for state selection
            GetState();

            //code for storing in Database
            int rowEffect = 0;
            try
            {

                cmd = new SqlCommand();
                cmd.Connection = con;
                cmd.CommandText = $"insert into Emp(name,Designation,joining_date,Salary,Gender,State) values('{tbName.Text}','{tbDesignation.Text}','{tbDob.Text}','{Convert.ToDecimal(tbSalary.Text)}','{gender}','{state}')";
                con.Open();
                rowEffect = cmd.ExecuteNonQuery();
                if (rowEffect > 0)
                {
                    Response.Write("<script>alert('Insertion Success')</script>");
                   // Response.Redirect("RegisDetails.aspx");
                }
                else
                    Response.Write("<script>alert('Insertion Failed')</script>");

                con.Close();
            }
            catch (Exception ex)
            {
                Response.Write(ex.Message);
            }
            showdata();
            tbName.Text=tbDesignation.Text=tbDob.Text=tbSalary.Text=gender="";
            ddState.SelectedIndex= 0;
            rbMale.Checked = rbFemale.Checked = false;
            
        }
        private void GetState()
        {
            if (ddState.SelectedIndex > 0)
                state = ddState.Text;
            //Response.Write(state);
        }
        private void GetGender()
        {
            if (rbMale.Checked)
                gender = rbMale.Text;
            else if (rbFemale.Checked)
                gender = rbFemale.Text;
            //Response.Write(gender);
        }

         protected void lbtName_Click(object sender, EventArgs e)
        {
            tbDob.TextMode = TextBoxMode.SingleLine;
            btnSubmit.Enabled = false;
            btnUpdate_User.Enabled = true;
            LinkButton clickedButton = (LinkButton)sender; //to get the clicked label 

            //string n = clickedButton.ID;
            string m= clickedButton.Text;

            storeInDB(m);
        }

        private void storeInDB(string m)
        {
            try
            {
                //con = new SqlConnection("Data Source=DESKTOP-344D91U\\SQLEXPRESS;Initial Catalog=Demo;Integrated Security=True");
                cmd = new SqlCommand();
                cmd.Connection=con;
                cmd.CommandText = $"select name,Designation,joining_date,Salary,state,gender from Emp where name='{m}'";
                con.Open();
                dr= cmd.ExecuteReader();
                
                if(dr.Read())
                {
                    DateTime joiningDate = Convert.ToDateTime(dr["joining_date"]);
                    tbDob.Text = joiningDate.ToString("dd-MM-yyyy");

                    tbName.Text = dr["name"].ToString();
                    tbDesignation.Text = dr["Designation"].ToString();
                    //tbDob.Text = dr["joining_date"].ToString();
                    tbSalary.Text = dr["Salary"].ToString();
                    ddState.Text = dr["state"].ToString();
                    string gender = dr["gender"].ToString();
                    if (gender == "Male")
                        rbMale.Checked = true;
                    else if (gender == "Female")
                        rbFemale.Checked = true;
                }
                con.Close();
                
            }
            catch (Exception ex)
            {
                Response.Write(ex.Message);
            }
        }

        protected void btnUpdate_User_Click(object sender, EventArgs e)
        {
            
            GetGender();
            GetState();
            
            //btnSubmit.Enabled = false;
            try
            {
                cmd = new SqlCommand();
                cmd.Connection = con;
                cmd.CommandText = $"UPDATE Emp SET name = '{tbName.Text}', Designation = '{tbDesignation.Text}', joining_date = '{tbDob.Text}',Salary = '{Convert.ToDecimal(tbSalary.Text)}', state = '{state}', gender = '{gender}' WHERE name = '{tbName.Text}'";
                con.Open();
                
                int rowEffect = cmd.ExecuteNonQuery();
                if (rowEffect > 0)
                {
                    Response.Write("<script>alert('Updatation Success')</script>");
                    // Response.Redirect("RegisDetails.aspx");
                }
                else
                    Response.Write("<script>alert('Updatation Failed')</script>");

                con.Close();
            }catch(Exception ex)
            {
                Response.Write(ex.Message);
            }
            btnUpdate_User.Enabled = false;
            btnSubmit.Enabled=true;
            tbName.Text = tbDesignation.Text = tbDob.Text = tbSalary.Text = gender = "";
            ddState.SelectedIndex = 0;
            rbMale.Checked = rbFemale.Checked = false;
            showdata();
        }

        protected void btnDelete_Click(object sender, EventArgs e)
        {
            Button b= (Button)sender;
            string s=b.CommandArgument;
            //Response.Write(s);
            cmd=new SqlCommand();   
            cmd.Connection = con;
            cmd.CommandText = $"Delete from Emp where SNO='{s}'";
            con.Open();
            int i = cmd.ExecuteNonQuery();
            con.Close();
            if (i > 0)
            {
                Response.Write("<script> alert('Record Deleted')</script>");
            }
            else
                Response.Write("<script> alert('Deletion Failed')</script>");

            showdata();
        }
    }
}