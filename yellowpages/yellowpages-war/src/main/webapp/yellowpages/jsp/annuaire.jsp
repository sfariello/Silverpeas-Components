<%
response.setHeader("Cache-Control","no-store"); //HTTP 1.1
response.setHeader("Pragma","no-cache"); //HTTP 1.0
response.setDateHeader ("Expires",-1); //prevents caching at the proxy server
%>

<%@ include file="checkYellowpages.jsp" %>
<%@ include file="contactsList.jsp.inc" %>

<%!
private String afficheArbo(String idNodeSelected, YellowpagesSessionController yellowpagesScc, int nbEsp) throws Exception {
    StringBuffer resultat = new StringBuffer();
	List tree = yellowpagesScc.getTree();
    StringBuffer espace = new StringBuffer();

	NodeDetail	nodeDetail	= null;
	String		nodeId		= null;
	int			nodeLevel	= 0;
	for (int i=0; i<tree.size(); i++) {
		nodeDetail	= (NodeDetail) tree.get(i);
		nodeId		= nodeDetail.getNodePK().getId();
		if (nodeId.equals("1") || nodeId.equals("2")) {
			//on affiche pas ces deux rubriques
		} else {
			if (i==0) {
				resultat.append("<option value=\"").append(nodeId).append("\">").append(yellowpagesScc.getComponentLabel()).append("</option>");
			} else {
				nodeLevel = nodeDetail.getLevel();
				espace = new StringBuffer();
				for (int j=0; j<nodeLevel-1; j++) {
					espace.append("&nbsp;&nbsp;&nbsp;");
				}
				resultat.append("<option value=\"").append(nodeId).append("\"");
				if (idNodeSelected.equals(nodeId))
					resultat.append("selected");
				resultat.append(">").append(espace.toString()).append(nodeDetail.getName()).append("</option>");
			}
		}
	}
   return resultat.toString();
}
%>

<%
Collection 		contacts 		= (Collection) request.getAttribute("Contacts");
TopicDetail 	currentTopic 	= (TopicDetail) request.getAttribute("CurrentTopic");
GroupDetail		group			= (GroupDetail) request.getAttribute("Group");
Boolean			bPortletMode	= (Boolean) request.getAttribute("PortletMode");
boolean 		portletMode 	= (bPortletMode != null && bPortletMode.booleanValue());
String			typeSearch		= (String) request.getAttribute("TypeSearch");
String			searchCriteria	= (String) request.getAttribute("SearchCriteria");

String 		profile 		= request.getParameter("Profile");
String 		action 			= request.getParameter("Action");

if (action==null)
    action = "GoTo";

String id = null;
if (currentTopic != null)
{
	id = currentTopic.getNodePK().getId();
}
else
{
	id = "group_"+group.getId();
}
%>

<HTML>
<HEAD>
<%
out.println(gef.getLookStyleSheet());
%>
<SCRIPT LANGUAGE="JAVASCRIPT" SRC="<%=m_context%>/util/javaScript/animation.js"></SCRIPT>
<SCRIPT LANGUAGE="JAVASCRIPT" SRC="<%=m_context%>/util/javaScript/overlib.js"></SCRIPT>
<SCRIPT LANGUAGE="JavaScript">
var printWindow = window;
var contactWindow = window;
function printList(){
	printWindow = SP_openWindow("PrintList", "printWindow", '800', '600', 'scrollbars=yes, alwayRaised');
}

function closeWindows()
{
	if (!printWindow.closed && printWindow.name== "printWindow")
    	printWindow.close(); 
    if (!contactWindow.closed &&  contactWindow.name== "contactWindow")
    	contactWindow.close(); 
}

function topicGoToSelected() {
    var id = document.topicDetailForm.selectTopic.options[document.topicDetailForm.selectTopic.selectedIndex].value;    
    document.topicDetailForm.Id.value = id;
    document.topicDetailForm.Action.value = "GoTo";
    document.topicDetailForm.action = "GoTo";
    document.topicDetailForm.submit();
}

function search()
{
	var typeSearch = document.topicDetailForm.selectTypeRech.options[document.topicDetailForm.selectTypeRech.selectedIndex].value;    
    document.topicDetailForm.Action.value = typeSearch;
    document.topicDetailForm.action = "Search";
    document.topicDetailForm.submit();
}

function contactGoToUserInTopic(id,topic){
    windowName = "contactWindow";
    windowParams = "directories=0,menubar=0,toolbar=0,alwaysRaised, scrollbars=yes, resizable=yes";
    width = <%=( resources.getSetting("popupWidth") == null ) ? "600" : resources.getSetting("popupWidth")%>;
    height = <%=( resources.getSetting("popupHeight") == null ) ? "480" : resources.getSetting("popupHeight")%>;
    contactWindow = SP_openWindow("", windowName, width, height, windowParams);
    document.contactForm.Action.value = "ViewContactInTopic";
    document.contactForm.ContactId.value = id;
    document.contactForm.TopicId.value = topic;
    document.contactForm.submit();
}

function goToUser(id){
    closeWindows();
    windowName = "contactWindow";
    windowParams = "directories=0,menubar=0,toolbar=0,height=400,width=600,alwaysRaised,scrollbars=yes";
    width = <%=( resources.getSetting("popupWidth") == null ) ? "600" : resources.getSetting("popupWidth")%>;
    height = <%=( resources.getSetting("popupHeight") == null ) ? "480" : resources.getSetting("popupHeight")%>;
    contactWindow = SP_openWindow("ViewUserFull?Id="+id, windowName, width, height, windowParams);
}

function topicGoTo(id) {
    document.topicDetailForm.action = "GoTo";
    document.topicDetailForm.Id.value = id;
    document.topicDetailForm.submit();
}

function manage(profile) {
    closeWindows();
	location.href = "topicManager.jsp?Profile=" + profile;
}

function clearCell() {
	document.topicDetailForm.SearchCriteria.value = ""; //vide la cellule
}
</SCRIPT>
</HEAD>
<BODY marginwidth=5 marginheight=5 leftmargin=5 topmargin=5>
<%  
Window 		window 		= gef.getWindow();

if (!portletMode)
{
	BrowseBar 	browseBar	= window.getBrowseBar();
	browseBar.setDomainName(spaceLabel);
	browseBar.setComponentName(componentLabel);
	browseBar.setPath(resources.getString("Consultation"));

	OperationPane operationPane = window.getOperationPane();
	operationPane.addOperation(resources.getIcon("yellowpages.printPage"), resources.getString("GML.print"), "javaScript:printList();");
}

Frame frame = gef.getFrame();
Board board = gef.getBoard();
out.println(window.printBefore());
if (!portletMode && ("admin".equals(profile) || "publisher".equals(profile)))
{    
	//Onglets
	TabbedPane tabbedPane = gef.getTabbedPane();
    tabbedPane.addTab(resources.getString("Consultation"),"#",true);
    tabbedPane.addTab(resources.getString("GML.management"),"javascript:manage('"+profile+"');",false);
    out.println(tabbedPane.print());
}
out.println(frame.printBefore());
out.println(board.printBefore());
%>

<TABLE CELLPADDING=1 CELLSPACING=0 BORDER=0 WIDTH="98%">
<FORM NAME="topicDetailForm" action="javaScript:search()" METHOD=POST>
  <input type="hidden" name="Action">
  <input type="hidden" name="Id" value="<%=id%>">
    <TR>
        <td>
            <!--Recherche-->
            <TABLE CELLPADDING=5 CELLSPACING=2 BORDER=0 WIDTH="98%">
                <TR>
                    <TD CLASS=intfdcolor4 NOWRAP>
                        <table cellpadding=0 cellspacing=0 border=0 width="100%">
                            <tr> 
                                <td nowrap valign="middle"> 
                                    <span class="textePetitBold">									
										<img src="<%=resources.getIcon("yellowpages.aide")%>" align="absbottom" border="0" onmouseover="return overlib('<%=Encode.javaStringToJsString(resources.getString("ExplikRecherche"))%>', CAPTION, '<%=Encode.javaStringToJsString(resources.getString("GML.search"))%>', WIDTH, 500);" onmouseout="return nd();">
                                    	&nbsp;
									</span>
									<span class=selectNS> 
									<select name="selectTypeRech">
										<option value="All" <% if (typeSearch == null || "All".equals(typeSearch)) { out.print("selected");} %>><%=resources.getString("SearchAllFields")%></option>
										<option value="LastName" <% if (typeSearch != null && "LastName".equals(typeSearch)) { out.print("selected");} %>><%=resources.getString("SearchLastName")%></option>
										<option value="FirstName" <% if (typeSearch != null && "FirstName".equals(typeSearch)) { out.print("selected");} %>><%=resources.getString("SearchFirstName")%></option>
										<option value="LastNameFirstName" <% if (typeSearch != null && "LastNameFirstName".equals(typeSearch)) { out.print("selected");} %>><%=resources.getString("SearchLastNameFirstName")%></option>												
									</select>
									&nbsp;
									</span>
									<input type="text" name="SearchCriteria" onCLick="javaScript:clearCell('<%=resources.getString("GML.search")%>');" size="15" maxlength="50" value="<% if (searchCriteria == null) {out.print(resources.getString("GML.search"));} else {out.print(searchCriteria);} %>">
                                </td>
                                <td valign="middle">
									<%
									  ButtonPane buttonPane = gef.getButtonPane();
									  buttonPane.addButton((Button) gef.getFormButton("Ok", "javaScript:search()", false));
									  out.println(buttonPane.print());
									%>
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>
            </table>
            <!--***************************-->
        </td>
        <%
		CompoSpace[] instances = yellowpagesScc.getYellowPagesInstances();
		if ( (instances!=null) && (instances.length>1) )
		{
		%>
        <TD><!--Container-->
            <!--Acc�s aux autres annuaires-->
            <table cellpadding=2 cellspacing=1 border=0 width="100%">
                <tr> 
                    <td align=center nowrap width="100%" height="24"> 
                        <span class=selectNS> 
                      <select name="select2" onChange="window.open(this.options[this.selectedIndex].value,'_self')">
                            <option selected><%=resources.getString("Access")%></option>
                    <%
                        for (int i = 0; i < instances.length; i++) {
                        
	                        if (!instances[i].getComponentId().equals(yellowpagesScc.getComponentId()))
	                        {
		                        if (!portletMode)
		                        	out.println("<option value=\""+m_context+"/Ryellowpages/"+instances[i].getComponentId()+"/Main\">"+instances[i].getSpaceLabel()+" - "+instances[i].getComponentLabel()+"</option>");
		                        else
		                        	out.println("<option value=\""+m_context+"/Ryellowpages/"+instances[i].getComponentId()+"/portlet\">"+instances[i].getSpaceLabel()+" - "+instances[i].getComponentLabel()+"</option>");
                        	}
                        }
                    %>
                     </select>
                </span>
                    </td>
                </tr>
            </table>
            <!--***************************-->
        </td>
        <%
        }
        %>
        <td>
            <!--Acc�s aux categories-->
            <table cellpadding=2 cellspacing=1 border=0 width="100%">
                <tr> 
                    <td align=center nowrap width="100%" height="24"> 
                        <span class=selectNS> 
                        <select name="selectTopic" onChange="topicGoToSelected()">
                			<%=afficheArbo(id, yellowpagesScc, 0)%>
                        </select>
                </span>
                    </td>
                </tr>
            </table>
            <!--***************************-->
        </td>
        <td width="100%">&nbsp;</td>
    </tr>
</table>
<!--Description de la cat�gorie-->
<%
String nodeName = null;
String nodeDesc = null;
if (group != null)
{
	nodeName = group.getName();
	nodeDesc = group.getDescription();
}
else
{
	if (!"0".equals(id))
	{
		NodeDetail nodeDetail = currentTopic.getNodeDetail();
		nodeName = Encode.javaStringToHtmlString(nodeDetail.getName().toUpperCase());
		nodeDesc = Encode.javaStringToHtmlString(nodeDetail.getDescription());
	}
}
if (nodeDesc != null && !nodeDesc.equals(""))
{
%>
    <div align="left">&nbsp;&nbsp;<b><%=nodeName%>&nbsp;:&nbsp;</b><%=nodeDesc%></div><br>
<%
}
	
	out.println(board.printAfter());
	out.println("<br>");
  displayContactsUser(yellowpagesScc, contacts, id, componentLabel, gef, request, session, resources, out);

	out.println(frame.printAfter());
	out.println(window.printAfter());
%>
</form>
<FORM NAME="contactForm" ACTION="contactManager.jsp" target="contactWindow" METHOD="POST">
    <input type="hidden" name="Action">
    <input type="hidden" name="ContactId">
    <input type="hidden" name="TopicId">
    <input type="hidden" name="Path">
</FORM>
</BODY>
</HTML>