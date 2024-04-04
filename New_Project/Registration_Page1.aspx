<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Registration_Page1.aspx.cs" Inherits="New_Project.Registration_Page1" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script type="text/javascript">
        $(document).ready(function () {
            function calculateTotalSalary() {
                var totalSalary = 0;
                // Loop through each row in the GridView
                $("#<%=GridView1.ClientID %> tr").each(function () {
                    // Find the Salary cell in the current row
                    var salaryCell = $(this).find("td:nth-child(5)");
                    // Extract the salary value and convert it to a number
                    var salary = parseFloat(salaryCell.text().replace(/,/g, ''));
                    // Add the salary to the total
                    if (!isNaN(salary)) {
                        totalSalary += salary;
                    }
                });
                // Set the total salary in the tbTotalSal TextBox
                $("#<%=tbTotalSal.ClientID %>").val(totalSalary.toFixed(2));
        }

        // Call the function initially
        calculateTotalSalary();

        // Bind the function to the GridView's row deletion event
            $("#<%=GridView1.ClientID %> .btnDelete").click(function () {
                calculateTotalSalary(); // Recalculate total salary after deletion
            });
            $("#btnSubmit").click(function () {
                //validation for Name
                var Name = $("#<%=tbName.ClientID %>").val();
                if (Name.trim() === "") {
                    $("#<%=lblNameMessage.ClientID %>").text("Please enter Name");
                    return false; // Prevent form submission
                } else {
                    $("#<%=lblNameMessage.ClientID %>").text(""); // Clear previous error message
                }
                // Validation for Designation
                var designation = $("#<%=tbDesignation.ClientID %>").val();
                if (designation.trim() === "") {
                    $("#<%=lblDesignationMessage.ClientID %>").text("Please enter Designation");
                    return false; // Prevent form submission
                } else {
                    $("#<%=lblDesignationMessage.ClientID %>").text(""); // Clear previous error message
                }

                // Validation for Date of Join
                var dateOfJoin = $("#<%=tbDob.ClientID %>").val();
                if (dateOfJoin.trim() === "") {
                    $("#<%=lblDateOfJoinMessage.ClientID %>").text("Please select Date of Join");
                    return false; // Prevent form submission
                } else {
                    $("#<%=lblDateOfJoinMessage.ClientID %>").text(""); // Clear previous error message
                }

                // Validation for Salary
                var salary = $("#<%=tbSalary.ClientID %>").val();
                if (salary.trim() === "") {
                    $("#<%=lblSalaryMessage.ClientID %>").text("Please enter Salary");
                    return false; // Prevent form submission
                } else {
                    $("#<%=lblSalaryMessage.ClientID %>").text(""); // Clear previous error message
                }

                // Validation for Gender
                var gender = $("input[name='gender']:checked").val();
                if (gender === undefined) {
                    $("#<%=lblGenderMessage.ClientID %>").text("Please select Gender");
                    return false; // Prevent form submission
                } else {
                    $("#<%=lblGenderMessage.ClientID %>").text(""); // Clear previous error message
                }

                // Validation for State
                var state = $("#<%=ddState.ClientID %> option:selected").text();
                if (state === "--select--") {
                    $("#<%=lblStateMessage.ClientID %>").text("Please select State");
                    return false; // Prevent form submission
                } else {
                    $("#<%=lblStateMessage.ClientID %>").text(""); // Clear previous error message
                }
            });
        });
    </script>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <h1>Employee Details</h1>
            Name
            <asp:TextBox ID="tbName" runat="server"></asp:TextBox>
            <asp:Label ID="lblNameMessage" runat="server" ForeColor="Red"></asp:Label>
            <br />
            <br />
            Designation
            <asp:TextBox ID="tbDesignation" runat="server"></asp:TextBox>
            <asp:Label ID="lblDesignationMessage" runat="server" ForeColor="Red"></asp:Label>
            <br />
            <br />
            Date of Join
            <asp:TextBox ID="tbDob" runat="server" TextMode="Date" ></asp:TextBox>
            <asp:Label ID="lblDateOfJoinMessage" runat="server" ForeColor="Red"></asp:Label>
            <br />
            <br />
            Salary
            <asp:TextBox ID="tbSalary" runat="server"></asp:TextBox>
            <asp:Label ID="lblSalaryMessage" runat="server" ForeColor="Red"></asp:Label>
            <br />
            <br />
            Gender :
            &nbsp;&nbsp;&nbsp;
            <asp:RadioButton Text="Male" ID="rbMale" GroupName="gender" runat="server" /> &nbsp; &nbsp;
            <asp:RadioButton Text="Female" ID="rbFemale" GroupName="gender" runat="server" />&nbsp;
            <asp:Label ID="lblGenderMessage" runat="server" ForeColor="Red"></asp:Label>
            <br />
            <br />
            State
            <asp:DropDownList ID="ddState" runat="server">
                <asp:ListItem Text="--select--"></asp:ListItem>
                <asp:ListItem Text="Andhra Pradesh"></asp:ListItem>
                <asp:ListItem Text="Arunachal Pradesh"></asp:ListItem>
                <asp:ListItem Text="Assam"></asp:ListItem>
                <asp:ListItem Text="Bihar"></asp:ListItem>
                <asp:ListItem Text="Chhattisgarh"></asp:ListItem>
                <asp:ListItem Text="Goa"></asp:ListItem>
                <asp:ListItem Text="Gujarat"></asp:ListItem>
                <asp:ListItem Text="Haryana"></asp:ListItem>
                <asp:ListItem Text="Himachal Pradesh"></asp:ListItem>
                <asp:ListItem Text="Jharkhand"></asp:ListItem>
                <asp:ListItem Text="Karnataka"></asp:ListItem>
                <asp:ListItem Text="Kerala"></asp:ListItem>
                <asp:ListItem Text="Madhya Pradesh"></asp:ListItem>
                <asp:ListItem Text="Telangana"></asp:ListItem>
                <asp:ListItem Text="Tamil Nadu"></asp:ListItem>
            </asp:DropDownList>
            <asp:Label ID="lblStateMessage" runat="server" ForeColor="Red"></asp:Label>
            <br />
            <br /> <br />
            <asp:Button ID="btnSubmit" Text="Submit" runat="server" OnClick="btnSubmit_Click"/> 
            <asp:Button ID="btnUpdate_User" Text="Update_User" runat="server"  OnClick="btnUpdate_User_Click" Enabled="False"/> 
            <br /> <br />
            <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" >
                <Columns>
                    <asp:TemplateField HeaderText="S.No">
                        <EditItemTemplate>
                            <asp:TextBox ID="TextBox7" runat="server" Text='<%# Bind("SNO") %>'></asp:TextBox>
                        </EditItemTemplate>
                        <ItemTemplate>
                            <asp:Label ID="Label7" runat="server" Text='<%# Bind("SNO") %>'></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Name">
                        <EditItemTemplate>
                            <asp:TextBox ID="TextBox1" runat="server" Text='<%# Bind("Name") %>'></asp:TextBox>
                        </EditItemTemplate>
                        <ItemTemplate>
                            <%--<asp:Label ID="Label1" runat="server" Text='<%# Bind("Name") %>'></asp:Label>--%>
                            <asp:LinkButton ID="lbtName" runat="server" Text='<%# Bind("Name") %>' OnClick="lbtName_Click"></asp:LinkButton>

                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Designation">
                        <EditItemTemplate>
                            <asp:TextBox ID="TextBox2" runat="server" Text='<%# Bind("Designation") %>'></asp:TextBox>
                        </EditItemTemplate>
                        <ItemTemplate>
                            <asp:Label ID="Label2" runat="server" Text='<%# Bind("Designation") %>'></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Date of Join">
                        <EditItemTemplate>
                            <asp:TextBox ID="TextBox3" runat="server" Text='<%# Bind("joining_Date") %>'></asp:TextBox>
                        </EditItemTemplate>
                        <ItemTemplate>
                            <asp:Label ID="Label3" runat="server" Text='<%# Bind("joining_Date","{0:dd-MM-yyyy}") %>'></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Salary">
                        <EditItemTemplate>
                            <asp:TextBox ID="TextBox4" runat="server" Text='<%# Bind("salary") %>'></asp:TextBox>
                        </EditItemTemplate>
                        <ItemTemplate>
                            <asp:Label ID="Label4" runat="server" Text='<%# Bind("salary") %>'></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Gender">
                        <EditItemTemplate>
                            <asp:TextBox ID="TextBox5" runat="server" Text='<%# Bind("Gender") %>'></asp:TextBox>
                        </EditItemTemplate>
                        <ItemTemplate>
                            <asp:Label ID="Label5" runat="server" Text='<%# Bind("Gender") %>'></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="State">
                        <EditItemTemplate>
                            <asp:TextBox ID="TextBox6" runat="server" Text='<%# Bind("State") %>'></asp:TextBox>
                        </EditItemTemplate>
                        <ItemTemplate>
                            <asp:Label ID="Label6" runat="server" Text='<%# Bind("State") %>'></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField >
                        <ItemTemplate>
                            <asp:Button ID="btnDelete" runat="server" Text="Delete" OnClick="btnDelete_Click" CommandArgument='<%# Eval("SNO") %>' />
                        </ItemTemplate>
                    </asp:TemplateField>
                </Columns>
            </asp:GridView>

            <br />
            <br />

            Total 
            <asp:TextBox ID="tbTotalSal" runat="server" ReadOnly="True"></asp:TextBox>
        </div>
    </form>
</body>
</html>