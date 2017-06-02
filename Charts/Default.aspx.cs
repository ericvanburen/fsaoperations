using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Charts_Default : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        //lbl_crct.Text = ViewState["correct"].ToString();
        //lbl_incrct.Text = ViewState["incorrect"].ToString();

        lbl_crct.Text = "10";
        lbl_incrct.Text = "20";
    }
}