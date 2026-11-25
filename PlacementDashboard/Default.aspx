<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Default.aspx.cs"
    Inherits="PlacementDashboard.Default" %>
<!DOCTYPE html>
<html lang="en">
<head runat="server">
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <title>Placement Analytics Portal</title>
    <link href="Content/Site.css" rel="stylesheet" />
</head>
<body>
    <form id="form1" runat="server">
        <header class="hero">
            <div class="container hero-inner">
                <div class="hero-copy">
                    <span class="hero-badge">01CE1523 &bull; Practical 9 &bull; ASP.NET Data Controls</span>
                    <h1>Campus Placement Analytics</h1>
                    <p>Track department-wise hiring outcomes, package benchmarks, and individual student placement records.</p>
                </div>
                <div class="hero-meta">
                    <span class="meta-pill">Academic Dataset &bull; LPA = Lakh Per Annum</span>
                </div>
            </div>
        </header>

        <main class="container main-content">
            <section class="kpi-grid" aria-label="Placement Summary">
                <article class="kpi-card kpi-indigo">
                    <div class="kpi-top">
                        <span class="kpi-label">Total Students</span>
                        <span class="kpi-icon" aria-hidden="true">
                            <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                                <path d="M17 21v-2a4 4 0 0 0-4-4H5a4 4 0 0 0-4 4v2"></path>
                                <circle cx="9" cy="7" r="4"></circle>
                                <path d="M23 21v-2a4 4 0 0 0-3-3.87"></path>
                                <path d="M16 3.13a4 4 0 0 1 0 7.75"></path>
                            </svg>
                        </span>
                    </div>
                    <strong class="kpi-value"><asp:Label ID="lblTotal" runat="server" /></strong>
                    <span class="kpi-sub">Registered candidates</span>
                </article>

                <article class="kpi-card kpi-emerald">
                    <div class="kpi-top">
                        <span class="kpi-label">Placed Students</span>
                        <span class="kpi-icon" aria-hidden="true">
                            <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                                <path d="M22 11.08V12a10 10 0 1 1-5.93-9.14"></path>
                                <polyline points="22 4 12 14.01 9 11.01"></polyline>
                            </svg>
                        </span>
                    </div>
                    <strong class="kpi-value"><asp:Label ID="lblPlaced" runat="server" /></strong>
                    <span class="kpi-sub">Confirmed offers</span>
                </article>

                <article class="kpi-card kpi-amber">
                    <div class="kpi-top">
                        <span class="kpi-label">Placement Rate</span>
                        <span class="kpi-icon" aria-hidden="true">
                            <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                                <line x1="18" y1="20" x2="18" y2="10"></line>
                                <line x1="12" y1="20" x2="12" y2="4"></line>
                                <line x1="6" y1="20" x2="6" y2="14"></line>
                            </svg>
                        </span>
                    </div>
                    <strong class="kpi-value"><asp:Label ID="lblRate" runat="server" /></strong>
                    <span class="kpi-sub">Overall conversion</span>
                </article>

                <article class="kpi-card kpi-teal">
                    <div class="kpi-top">
                        <span class="kpi-label">Highest Package</span>
                        <span class="kpi-icon" aria-hidden="true">
                            <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                                <polygon points="12 2 15.09 8.26 22 9.27 17 14.14 18.18 21.02 12 17.77 5.82 21.02 7 14.14 2 9.27 8.91 8.26 12 2"></polygon>
                            </svg>
                        </span>
                    </div>
                    <strong class="kpi-value"><asp:Label ID="lblHighest" runat="server" /> <span class="unit">LPA</span></strong>
                    <span class="kpi-sub">Peak campus offer</span>
                </article>
            </section>

            <div class="workspace-grid">
                <section class="surface-card records-card">
                    <div class="card-header">
                        <div>
                            <h2>Student Placement Records</h2>
                            <p class="card-subtitle">Filter by department or status, click headers to sort, and select View to inspect.</p>
                        </div>
                    </div>

                    <div class="filter-toolbar">
                        <div class="filter-field">
                            <asp:Label runat="server" AssociatedControlID="ddlDepartment" Text="Department" />
                            <asp:DropDownList ID="ddlDepartment" runat="server" AutoPostBack="true"
                                CssClass="select-control" OnSelectedIndexChanged="FilterChanged">
                                <asp:ListItem Value="All">All Departments</asp:ListItem>
                                <asp:ListItem>CE</asp:ListItem>
                                <asp:ListItem>IT</asp:ListItem>
                                <asp:ListItem>EC</asp:ListItem>
                            </asp:DropDownList>
                        </div>

                        <div class="filter-field">
                            <asp:Label runat="server" AssociatedControlID="ddlStatus" Text="Placement Status" />
                            <asp:DropDownList ID="ddlStatus" runat="server" AutoPostBack="true"
                                CssClass="select-control" OnSelectedIndexChanged="FilterChanged">
                                <asp:ListItem Value="All">All Statuses</asp:ListItem>
                                <asp:ListItem>Placed</asp:ListItem>
                                <asp:ListItem>Pending</asp:ListItem>
                            </asp:DropDownList>
                        </div>
                    </div>

                    <div class="table-wrap">
                        <asp:GridView ID="gvStudents" runat="server" DataSourceID="dsStudents"
                            AutoGenerateColumns="false" DataKeyNames="Id" CssClass="data-grid"
                            GridLines="None" AllowPaging="true" PageSize="6" AllowSorting="true"
                            OnPageIndexChanging="GridChanging" OnSorting="GridSorting"
                            OnSelectedIndexChanged="StudentSelected" OnRowDataBound="GridRowDataBound"
                            EmptyDataText="No placement records match the selected filters.">
                            <Columns>
                                <asp:BoundField DataField="Enrollment" HeaderText="Enrollment" />
                                <asp:BoundField DataField="StudentName" HeaderText="Student Name" SortExpression="StudentName" />
                                <asp:BoundField DataField="Department" HeaderText="Dept." SortExpression="Department" />
                                <asp:BoundField DataField="Company" HeaderText="Company" NullDisplayText="-" />
                                <asp:BoundField DataField="PackageLpa" HeaderText="Package (LPA)"
                                    DataFormatString="{0:0.00}" NullDisplayText="-" SortExpression="PackageLpa" />
                                <asp:BoundField DataField="Status" HeaderText="Status" />
                                <asp:CommandField ShowSelectButton="true" SelectText="View" ControlStyle-CssClass="btn-view" />
                            </Columns>
                            <SelectedRowStyle CssClass="selected-row" />
                            <PagerStyle CssClass="grid-pager" />
                            <EmptyDataRowStyle CssClass="empty-state" />
                        </asp:GridView>
                    </div>
                </section>

                <aside class="surface-card details-card">
                    <div class="card-header">
                        <div>
                            <h2>Selected Student Details</h2>
                            <p class="card-subtitle">Detailed profile of the selected candidate.</p>
                        </div>
                    </div>

                    <asp:DetailsView ID="dvStudent" runat="server" DataSourceID="dsDetails"
                        AutoGenerateRows="false" CssClass="details-table" GridLines="None"
                        EmptyDataText="Select View beside any student row to inspect full placement details.">
                        <Fields>
                            <asp:BoundField DataField="Enrollment" HeaderText="Enrollment" />
                            <asp:BoundField DataField="StudentName" HeaderText="Student Name" />
                            <asp:BoundField DataField="Department" HeaderText="Department" />
                            <asp:BoundField DataField="Email" HeaderText="Email" />
                            <asp:BoundField DataField="Company" HeaderText="Company" NullDisplayText="-" />
                            <asp:BoundField DataField="PackageLpa" HeaderText="Package (LPA)"
                                DataFormatString="{0:0.00}" NullDisplayText="-" />
                            <asp:BoundField DataField="Status" HeaderText="Status" />
                        </Fields>
                        <EmptyDataRowStyle CssClass="empty-state" />
                    </asp:DetailsView>
                </aside>
            </div>

            <section class="surface-card companies-section">
                <div class="card-header">
                    <div>
                        <h2>Company Hiring Summary</h2>
                        <p class="card-subtitle">All placed students grouped by recruiting organization.</p>
                    </div>
                </div>

                <div class="company-grid">
                    <asp:Repeater ID="rptCompanies" runat="server" DataSourceID="dsCompanies">
                        <ItemTemplate>
                            <article class="company-card">
                                <div class="company-head">
                                    <span class="company-dot" aria-hidden="true"></span>
                                    <h3><%#: Eval("Company") %></h3>
                                </div>
                                <div class="company-metrics">
                                    <div class="metric-row">
                                        <span>Students Placed</span>
                                        <strong><%#: Eval("PlacedCount") %></strong>
                                    </div>
                                    <div class="metric-row">
                                        <span>Highest Package</span>
                                        <strong class="package-pill"><%#: Eval("HighestPackage", "{0:0.00}") %> LPA</strong>
                                    </div>
                                </div>
                            </article>
                        </ItemTemplate>
                    </asp:Repeater>
                </div>
            </section>
        </main>

        <footer class="site-footer">
            <div class="container">
                <p>Practical 9 &bull; ASP.NET Web Forms Data Controls &bull; Campus Placement Analytics Portal</p>
            </div>
        </footer>

        <asp:SqlDataSource ID="dsStudents" runat="server"
            ConnectionString="<%$ ConnectionStrings:PlacementDb %>"
            SelectCommand="SELECT Id,Enrollment,StudentName,Department,Company,PackageLpa,Status
                FROM Students WHERE (@Department='All' OR Department=@Department)
                AND (@Status='All' OR Status=@Status) ORDER BY Id">
            <SelectParameters>
                <asp:ControlParameter Name="Department" ControlID="ddlDepartment"
                    PropertyName="SelectedValue" Type="String" DefaultValue="All" />
                <asp:ControlParameter Name="Status" ControlID="ddlStatus"
                    PropertyName="SelectedValue" Type="String" DefaultValue="All" />
            </SelectParameters>
        </asp:SqlDataSource>

        <asp:SqlDataSource ID="dsDetails" runat="server"
            ConnectionString="<%$ ConnectionStrings:PlacementDb %>"
            SelectCommand="SELECT Enrollment,StudentName,Department,Email,Company,PackageLpa,Status
                FROM Students WHERE Id=@Id">
            <SelectParameters>
                <asp:ControlParameter Name="Id" ControlID="gvStudents"
                    PropertyName="SelectedValue" Type="Int32" DefaultValue="0" />
            </SelectParameters>
        </asp:SqlDataSource>

        <asp:SqlDataSource ID="dsCompanies" runat="server"
            ConnectionString="<%$ ConnectionStrings:PlacementDb %>"
            SelectCommand="SELECT Company,COUNT(*) AS PlacedCount,MAX(PackageLpa) AS HighestPackage
                FROM Students WHERE Status='Placed' GROUP BY Company ORDER BY Company" />
    </form>
</body>
</html>
