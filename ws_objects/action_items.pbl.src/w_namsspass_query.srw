﻿$PBExportHeader$w_namsspass_query.srw
forward
global type w_namsspass_query from window
end type
type dw_providers from datawindow within w_namsspass_query
end type
type st_status from statictext within w_namsspass_query
end type
type cb_14 from commandbutton within w_namsspass_query
end type
type cb_13 from commandbutton within w_namsspass_query
end type
type cb_11 from commandbutton within w_namsspass_query
end type
type cb_9 from commandbutton within w_namsspass_query
end type
type cb_7 from commandbutton within w_namsspass_query
end type
type cb_6 from commandbutton within w_namsspass_query
end type
type cb_5 from commandbutton within w_namsspass_query
end type
type cb_4 from commandbutton within w_namsspass_query
end type
type cb_3 from commandbutton within w_namsspass_query
end type
type cb_1 from commandbutton within w_namsspass_query
end type
type st_pracs from statictext within w_namsspass_query
end type
type cb_view from commandbutton within w_namsspass_query
end type
type cb_batch from commandbutton within w_namsspass_query
end type
type cb_prac from commandbutton within w_namsspass_query
end type
type cb_2 from commandbutton within w_namsspass_query
end type
type st_1 from statictext within w_namsspass_query
end type
type sle_path from singlelineedit within w_namsspass_query
end type
type cb_close from commandbutton within w_namsspass_query
end type
type cb_run from commandbutton within w_namsspass_query
end type
type gb_prac from groupbox within w_namsspass_query
end type
type cb_10 from commandbutton within w_namsspass_query
end type
type ole_browser from olecustomcontrol within w_namsspass_query
end type
end forward

global type w_namsspass_query from window
integer width = 3365
integer height = 2456
boolean titlebar = true
string title = "NAMSS PASS Export"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
long backcolor = 33551856
string icon = "AppIcon!"
boolean center = true
dw_providers dw_providers
st_status st_status
cb_14 cb_14
cb_13 cb_13
cb_11 cb_11
cb_9 cb_9
cb_7 cb_7
cb_6 cb_6
cb_5 cb_5
cb_4 cb_4
cb_3 cb_3
cb_1 cb_1
st_pracs st_pracs
cb_view cb_view
cb_batch cb_batch
cb_prac cb_prac
cb_2 cb_2
st_1 st_1
sle_path sle_path
cb_close cb_close
cb_run cb_run
gb_prac gb_prac
cb_10 cb_10
ole_browser ole_browser
end type
global w_namsspass_query w_namsspass_query

type variables
long il_pracs[]
long il_export_id
integer ii_letter = 1390
string is_prac_names[]
string is_file
string is_np_vendor
string is_np_client
gs_batch_search ist_search
n_winhttp in_http
end variables

forward prototypes
public function string of_get_token ()
public function integer of_get_ids ()
public function string of_find_prac (string as_npi)
end prototypes

public function string of_get_token ();integer p
long ll_pos1, ll_pos2, ll_pos3
String ls_url
string ls_source
string ls_token
string ls_auth
any la_res
inet iinet_base
n_cst_datetime lnv

long flags = 0
string  TargetFrame = ""
string  Headers = "Content-Type: application/x-www-form-urlencoded"  //_vbCrlf
string ls_post


//ls_url =  "https://api.namsspass.com/api/v1/token/"

//ls_post = "vendor_key=" + is_np_vendor + "&client_key=" + is_np_client + "&format=json"
//https://api.namsspass.com/api/v1/token/?vendor_key=8bnftb43smimk5uehq3upuhj9r&client_key=hb2rg2b143617dq77u02jregaf14972&format=xml"
//messagebox("post", ls_post)
//ole_browser.Object.Navigate(ls_url, Flags, TargetFrame, ls_Post, Headers)	
//ls_url = "https://api.namsspass.com/api/v1/token/?vendor_key=" + is_np_vendor + "&client_key=" + is_np_client + "&format=json"
//ls_url = "https://api.namsspass.com/api/v1/token/?vendor_key=8bnftb43smimk5uehq3upuhj9r&client_key=hb2rg2b143617dq77u02jregaf14972&format=json"


//return "test"


//ole_browser.Object.Navigate(ls_url)	
lnv.of_wait(2)

ls_source = ole_Browser.object.Document.All.Item(0).innerHTML

debugbreak()
ll_pos1 = pos(ls_source, "vendor_key_authorized",1)
//ll_pos2 = pos(ls_source, ',"',ll_pos1)
ll_pos1+= 23
ll_pos3 = pos(ls_source, ',"c',ll_pos1)
ls_auth = mid(ls_source, ll_pos1,ll_pos3 - ll_pos1)
if ls_auth <> "true" then
	messagebox("NAMSS PASS", "Vendor authorization failed:~r" + is_np_vendor )
	return "failed"
end if

ll_pos1 = pos(ls_source, "client_key_authorized",1)
ll_pos1+= 23
ll_pos3 = pos(ls_source, '},',ll_pos1)
ls_auth = mid(ls_source, ll_pos1,ll_pos3 - ll_pos1)
if ls_auth <> "true" then
	messagebox("NAMSS PASS", "User authorization failed:~r" + is_np_client )
	return "failed"
end if


ls_token = mid(ls_source, ll_pos2,ll_pos3 - ll_pos2)

ll_pos1 = pos(ls_source, "auth_token",1)
ll_pos2 = pos(ls_source, '":"',ll_pos1)
ll_pos2+= 3
ll_pos3 = pos(ls_source, '"}]',ll_pos2)

ls_token = mid(ls_source, ll_pos2,ll_pos3 - ll_pos2)

//openwithparm(w_sql_msg,ls_source)
messagebox("token", ls_token)

return ls_token



//<BODY>{"results":[{"auth_token":"8719124d-1ac6-4b22-94e5-b770fcc65d8b"}],"authentication":{"vendor_key_authorized":true,"client_key_authorized":true},"meta":{"is_production":false,"method":"GET","is_multipart":false,"description":"/api/v1/token/","version":"1.0","total_results":1}} </BODY>
end function

public function integer of_get_ids ();is_np_vendor = "8bnftb43smimk5uehq3upuhj9r"
is_np_client = "hb2rg2b143617dq77u02jregaf14972"

return 1
end function

public function string of_find_prac (string as_npi);integer li_FileNum
string ls_url
integer p
long ll_pos1, ll_pos2, ll_pos3
string ls_source
string ls_token
string ls_auth
any la_res
inet iinet_base
n_cst_datetime lnv

ls_url =  gs_temp_path + "namsspasstotals.htm"

li_FileNum = FileOpen(ls_url,   LineMode!, Write!, LockWrite!, Replace!)

FileWrite(li_FileNum,'<form name="namsspass_totals"')
FileWrite(li_FileNum,'	action="https://api.namsspass.com/api/v1/affiliation/totals/" method="post">')
FileWrite(li_FileNum,'	<input type="hidden" name="vendor_key" value="' + is_np_vendor + '">' )
FileWrite(li_FileNum,'	<input type="hidden" name="client_key" value="' + is_np_client + '">' )
FileWrite(li_FileNum,'	<input type="hidden" name="npi" value="' + as_npi + '">' )
FileWrite(li_FileNum,'	<input type="hidden" name="format" value="json">' )
FileWrite(li_FileNum,	'<input type="submit" name="Submit" value="NAMSS PASS">' )
FileWrite(li_FileNum,'</form>')

FileClose(li_FileNum)

ole_browser.Object.Navigate(ls_url)

lnv.of_wait(1)

ole_browser.object.document.Forms("namsspass_totals").Submit.Click

lnv.of_wait(2)

ls_source = ole_Browser.object.Document.All.Item(0).innerHTML


ll_pos1 = pos(ls_source, "vendor_key_authorized",1)
//ll_pos2 = pos(ls_source, ',"',ll_pos1)
ll_pos1+= 23
ll_pos3 = pos(ls_source, ',"c',ll_pos1)
ls_auth = mid(ls_source, ll_pos1,ll_pos3 - ll_pos1)
if ls_auth <> "true" then
	messagebox("NAMSS PASS", "Vendor authorization failed:~r" + is_np_vendor )
	return "-1"
end if

ll_pos1 = pos(ls_source, "client_key_authorized",1)
ll_pos1+= 23
ll_pos3 = pos(ls_source, '},',ll_pos1)
ls_auth = mid(ls_source, ll_pos1,ll_pos3 - ll_pos1)
if ls_auth <> "true" then
	messagebox("NAMSS PASS", "User authorization failed:~r" + is_np_client )
	return "-2"
end if


ls_token = mid(ls_source, ll_pos2,ll_pos3 - ll_pos2)

ll_pos1 = pos(ls_source, "total_records_found",1)
ll_pos2 = pos(ls_source,":",ll_pos1)
ll_pos2++
ll_pos3 = pos(ls_source, "}",ll_pos2)

ls_token = mid(ls_source, ll_pos2,ll_pos3 - ll_pos2)

//openwithparm(w_sql_msg,ls_source)
//messagebox("Found records", ls_token)

return ls_token






end function

on w_namsspass_query.create
this.dw_providers=create dw_providers
this.st_status=create st_status
this.cb_14=create cb_14
this.cb_13=create cb_13
this.cb_11=create cb_11
this.cb_9=create cb_9
this.cb_7=create cb_7
this.cb_6=create cb_6
this.cb_5=create cb_5
this.cb_4=create cb_4
this.cb_3=create cb_3
this.cb_1=create cb_1
this.st_pracs=create st_pracs
this.cb_view=create cb_view
this.cb_batch=create cb_batch
this.cb_prac=create cb_prac
this.cb_2=create cb_2
this.st_1=create st_1
this.sle_path=create sle_path
this.cb_close=create cb_close
this.cb_run=create cb_run
this.gb_prac=create gb_prac
this.cb_10=create cb_10
this.ole_browser=create ole_browser
this.Control[]={this.dw_providers,&
this.st_status,&
this.cb_14,&
this.cb_13,&
this.cb_11,&
this.cb_9,&
this.cb_7,&
this.cb_6,&
this.cb_5,&
this.cb_4,&
this.cb_3,&
this.cb_1,&
this.st_pracs,&
this.cb_view,&
this.cb_batch,&
this.cb_prac,&
this.cb_2,&
this.st_1,&
this.sle_path,&
this.cb_close,&
this.cb_run,&
this.gb_prac,&
this.cb_10,&
this.ole_browser}
end on

on w_namsspass_query.destroy
destroy(this.dw_providers)
destroy(this.st_status)
destroy(this.cb_14)
destroy(this.cb_13)
destroy(this.cb_11)
destroy(this.cb_9)
destroy(this.cb_7)
destroy(this.cb_6)
destroy(this.cb_5)
destroy(this.cb_4)
destroy(this.cb_3)
destroy(this.cb_1)
destroy(this.st_pracs)
destroy(this.cb_view)
destroy(this.cb_batch)
destroy(this.cb_prac)
destroy(this.cb_2)
destroy(this.st_1)
destroy(this.sle_path)
destroy(this.cb_close)
destroy(this.cb_run)
destroy(this.gb_prac)
destroy(this.cb_10)
destroy(this.ole_browser)
end on

event open;//Start Code Change ----04.15.2013 #V14 maha - window created

select export_id into :il_export_id from export_header where export_name = 'NAMSSPASSExport';

if il_export_id = 0 or isnull(il_export_id) then
	messagebox("NAMSSPASSExport", "There is no Export named NAMSSPASSExport available.")
	close( this)
	return
end if
	
sle_path.text = gs_temp_path

is_file = gs_temp_path + "NAMSSPASSExport.xls"

of_get_ids( )  //Start Code Change ----08.14.2013 #V14 maha
end event

type dw_providers from datawindow within w_namsspass_query
integer x = 78
integer y = 424
integer width = 3150
integer height = 1696
integer taborder = 70
string title = "none"
string dataobject = "d_namsspass_get_pracs"
boolean hscrollbar = true
boolean vscrollbar = true
boolean border = false
boolean livescroll = true
end type

type st_status from statictext within w_namsspass_query
integer x = 96
integer y = 340
integer width = 1362
integer height = 76
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "Progress"
boolean focusrectangle = false
end type

type cb_14 from commandbutton within w_namsspass_query
integer x = 544
integer y = 232
integer width = 530
integer height = 92
integer taborder = 120
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "NAMSS PASS Search"
end type

event clicked;long rc
long r
integer li_cnt
string ls_npi
string res
string ls_name

dw_providers.settransobject(sqlca)
rc = dw_providers.rowcount()

for r = 1 to rc
	if dw_providers.getitemnumber(r,"selected") = 1 then
		ls_name =  dw_providers.getitemstring(r,"full_name")
		ls_npi =  dw_providers.getitemstring(r,"npi_number")
		st_status.text = "Searching for " + ls_name
		res = of_find_prac(ls_npi)
		li_cnt = integer(res)
		dw_providers.setitem(r, "num_found", li_cnt)
		if li_cnt < 1 then dw_providers.setitem(r,"selected", 0)
	end if
next

st_status.text = "Completed search"
		
end event

type cb_13 from commandbutton within w_namsspass_query
integer x = 78
integer y = 232
integer width = 453
integer height = 92
integer taborder = 110
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Provider List"
end type

event clicked;long rc
long r
string ls_npi


dw_providers.settransobject(sqlca)
rc = dw_providers.retrieve(il_pracs[])




end event

type cb_11 from commandbutton within w_namsspass_query
integer x = 3406
integer y = 856
integer width = 343
integer height = 88
integer taborder = 100
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "totals file"
end type

event clicked;integer li_FileNum
string ls_url
integer p
long ll_pos1, ll_pos2, ll_pos3
string ls_source
string ls_token
string ls_auth
any la_res
inet iinet_base
n_cst_datetime lnv

ls_url =  gs_temp_path + "namsspasstotals.htm"

li_FileNum = FileOpen(ls_url,   LineMode!, Write!, LockWrite!, Replace!)

FileWrite(li_FileNum,'<form name="namsspass_totals"')
FileWrite(li_FileNum,'	action="https://api.namsspass.com/api/v1/affiliation/totals/" method="post">')
FileWrite(li_FileNum,'	<input type="hidden" name="vendor_key" value="' + is_np_vendor + '">' )
FileWrite(li_FileNum,'	<input type="hidden" name="client_key" value="' + is_np_client + '">' )
FileWrite(li_FileNum,'	<input type="hidden" name="npi" value="1234567890">' )
FileWrite(li_FileNum,'	<input type="hidden" name="format" value="json">' )
FileWrite(li_FileNum,	'<input type="submit" name="Submit" value="NAMSS PASS">' )
FileWrite(li_FileNum,'</form>')

FileClose(li_FileNum)

ole_browser.Object.Navigate(ls_url)

lnv.of_wait(1)

ole_browser.object.document.Forms("namsspass_totals").Submit.Click

lnv.of_wait(2)

ls_source = ole_Browser.object.Document.All.Item(0).innerHTML


ll_pos1 = pos(ls_source, "vendor_key_authorized",1)
//ll_pos2 = pos(ls_source, ',"',ll_pos1)
ll_pos1+= 23
ll_pos3 = pos(ls_source, ',"c',ll_pos1)
ls_auth = mid(ls_source, ll_pos1,ll_pos3 - ll_pos1)
if ls_auth <> "true" then
	messagebox("NAMSS PASS", "Vendor authorization failed:~r" + is_np_vendor )
	return 
end if

ll_pos1 = pos(ls_source, "client_key_authorized",1)
ll_pos1+= 23
ll_pos3 = pos(ls_source, '},',ll_pos1)
ls_auth = mid(ls_source, ll_pos1,ll_pos3 - ll_pos1)
if ls_auth <> "true" then
	messagebox("NAMSS PASS", "User authorization failed:~r" + is_np_client )
	return
end if


ls_token = mid(ls_source, ll_pos2,ll_pos3 - ll_pos2)

ll_pos1 = pos(ls_source, "total_records_found",1)
ll_pos2 = pos(ls_source,":",ll_pos1)
ll_pos2++
ll_pos3 = pos(ls_source, "}",ll_pos2)

ls_token = mid(ls_source, ll_pos2,ll_pos3 - ll_pos2)

//openwithparm(w_sql_msg,ls_source)
messagebox("Found records", ls_token)

return 






end event

type cb_9 from commandbutton within w_namsspass_query
integer x = 4105
integer y = 348
integer width = 343
integer height = 92
integer taborder = 100
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "links"
end type

event clicked;//http://www.rgagnon.com/pbdetails/pb-0202.html
//http://www.netomatix.com/HttpPostData.aspx
end event

type cb_7 from commandbutton within w_namsspass_query
integer x = 4073
integer y = 472
integer width = 343
integer height = 92
integer taborder = 90
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "letter id"
end type

event clicked;integer p
long ll_pos1, ll_pos2, ll_pos3
long flags = 0
string  TargetFrame = ""
string  Headers = "Content-Type: application/x-www-form-urlencoded"  //_vbCrlf
String ls_url

string ls_source
string ls_token
string ls_auth
string ls_post
any la_res
n_cst_datetime lnv

ls_url = "https://api.namsspass.com/api/v1/update/file/ticket/"

ls_post = "vendor_key=" + is_np_vendor + "&client_key=" + is_np_client + "&letter_id="+ string(ii_letter) +"&file_upload=" + is_file + "&format=json&post_live=false"
//https://api.namsspass.com/api/v1/token/?vendor_key=8bnftb43smimk5uehq3upuhj9r&client_key=hb2rg2b143617dq77u02jregaf14972&format=xml"
messagebox("post", ls_post)
//clipboard(ls_url)

ole_browser.Object.Navigate(ls_url, Flags, TargetFrame, ls_Post, Headers)	
lnv.of_wait(3)

ls_source = ole_Browser.object.Document.All.Item(0).innerHTML
messagebox("Result", ls_source)
//ll_pos1 = pos(ls_source, "_token",1)
//ll_pos2 = pos(ls_source, "class=tx>",ll_pos1)
//ll_pos2+= 9
//ll_pos3 = pos(ls_source, "</",ll_pos2)
//
//ls_token = mid(ls_source, ll_pos2,ll_pos3 - ll_pos2)
//
//messagebox("token", ls_token)

//      Sub Command1_Click()
//         Dim URL As String
//         Dim Flags As Long
//         Dim TargetFrame As String
//         Dim PostData() As Byte
//         Dim Headers As String
//
//         URL = "http://YourServer" ' A URL that will accept a POST
//         Flags = 0
//         TargetFrame = ""
//
//         PostData = "Information sent to host"
//
//         ' VB creates a Unicode string by default so we need to
//         ' convert it back to Single byte character set.
//         PostData = StrConv(PostData, vbFromUnicode)
//
//         Headers = "Content-Type: application/x-www-form-urlencoded" & _
//            vbCrlf
//         WebBrowser1.Navigate URL, Flags, TargetFrame, PostData, Headers
//      End Sub



//http://www.netomatix.com/HttpPostData.aspx
end event

type cb_6 from commandbutton within w_namsspass_query
integer x = 3675
integer y = 504
integer width = 343
integer height = 92
integer taborder = 80
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "tokenpost"
end type

event clicked;integer p
String ls_url
string ls_source
inet iinet_base

ls_url = "https://api.namsspass.com/api/v1/token/"


ole_browser.Object.Navigate(ls_url, "vendor_key=8bnftb43smimk5uehq3upuhj9r&client_key=hb2rg2b143617dq77u02jregaf14972&format=xml")	
//ls_source = ole_browser.object.getsource()












//if LenA(ls_url) < 6 then 
//	messagebox("Error","Invalid URL")
//	return
//end if
//
//if gi_citrix = 1 then
//	of_open_web(ls_url)
//else
//	String ls_null
//	setnull(ls_null)
//	ShellExecuteA ( Handle( This ), "open", 'IEXPLORE', ls_url , ls_Null, 4)
//	
//	//---------------------------- APPEON END ----------------------------
//	
//end if
end event

type cb_5 from commandbutton within w_namsspass_query
integer x = 3945
integer y = 840
integer width = 343
integer height = 92
integer taborder = 80
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "token"
end type

event clicked;of_get_ids( )
of_get_token( )

//ls_url = "https://api.namsspass.com/api/v1/token/?vendor_key=8bnftb43smimk5uehq3upuhj9r&client_key=hb2rg2b143617dq77u02jregaf14972&format=xml"
//
//
//ole_browser.Object.Navigate(ls_url)	
//lnv.of_wait(3)
//
//ls_source = ole_Browser.object.Document.All.Item(0).innerHTML
//
//ll_pos1 = pos(ls_source, "_token",1)
//ll_pos2 = pos(ls_source, "class=tx>",ll_pos1)
//ll_pos2+= 9
//ll_pos3 = pos(ls_source, "</",ll_pos2)
//
//ls_token = mid(ls_source, ll_pos2,ll_pos3 - ll_pos2)
//
//messagebox("token", ls_token)

end event

type cb_4 from commandbutton within w_namsspass_query
integer x = 3712
integer y = 424
integer width = 343
integer height = 92
integer taborder = 40
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "token test"
end type

event clicked;
Boolean lb_result
String ls_URL, ls_data
string ls_resp
long p1
long p2

SetPointer(HourGlass!)

ls_URL  = "https://api.namsspass.com/api/v1/token/?"
 ls_data = "vendor_key=8bnftb43smimk5uehq3upuhj9r&"
 ls_data+= "client_key=hb2rg2b143617dq77u02jregaf14972"
//  ls_data+= "&format=json"


lb_result = in_http.Open("POST", ls_URL)
If Not lb_result Then
	MessageBox("Send Error","Post")
	return 0
end if

//in_http.SetRequestHeader("Content-Length", String(Len(ls_data)))
//in_http.SetRequestHeader("Content-Type", "application/x-www-form-urlencoded")
//MessageBox("Send data",ls_data)
//debugbreak()

ls_url+= ls_data
//clipboard(ls_url)

ls_url = "https://api.namsspass.com/api/v1/token/?vendor_key=8bnftb43smimk5uehq3upuhj9r&client_key=hb2rg2b143617dq77u02jregaf14972&format=xml"

lb_result = in_http.Send(ls_url)

If Not lb_result Then
	MessageBox("Send Error #" + &
					String(Error.Number), Error.Text, StopSign!)
	Return
End If

If in_http.ResponseText = "" Then
	ls_resp = "No response returned"
Else
	ls_resp = in_http.ResponseText
End If




MessageBox("Response",ls_resp)
end event

type cb_3 from commandbutton within w_namsspass_query
integer x = 3730
integer y = 324
integer width = 343
integer height = 92
integer taborder = 40
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "Totals alt"
end type

event clicked;
//!!!HTTPS IS UNSUPPORTED BY POSTURL!!!



//Blob lblb_args 
//String ls_header
//String ls_url
//String ls_args
//string ls_result
//long ll_length
//integer li_rc
//inet iinet
//n_ir_msgbox ir
//
//li_rc = GetContextService( "Internet", iinet )
//
//IF li_rc = 1 THEN
//   ir = CREATE n_ir_msgbox
//  ls_URL  = "https://api.namsspass.com/api/v1/affiliation/totals/?"
//   ls_args = "vendor_key=8bnftb43smimk5uehq3upuhj9r&user_key=hb2rg2b143617dq77u02jregaf14972&npi=012345678"
//   lblb_args = Blob( ls_args )
//   ll_length = Len( lblb_args )
//   ls_header = "Content-Type: "  +    "application/x-www-form-urlencoded~n" +  "Content-Length: " + String( ll_length ) + "~n~n"
//   li_rc = iinet.PostURL( ls_url, lblb_args, ls_header, ir )
//END IF
//
//messagebox("",li_rc)
//messagebox("",string(ir))


end event

type cb_1 from commandbutton within w_namsspass_query
integer x = 3849
integer y = 616
integer width = 343
integer height = 92
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "Totals Test"
end type

event clicked;//test affiliation
Boolean lb_result
String ls_URL, ls_data
string ls_send
string ls_resp
long p1
long p2

SetPointer(HourGlass!)
DEBUGBREAK()
ls_URL  = "https://api.namsspass.com/api/v1/affiliation/totals/?"
 ls_data = "vendor_key=8bnftb43smimk5uehq3upuhj9r&"
 ls_data+= "client_key=hb2rg2b143617dq77u02jregaf14972&"
 ls_data+= "npi=01234567890"
ls_data+= "&format=json"
 

lb_result = in_http.Open("POST", ls_URL)
If Not lb_result Then
	MessageBox("Send Error","Post")
	return 0
end if

ls_send  = ls_url + ls_data
//MessageBox("POST url", ls_send)
clipboard(ls_send)
 
//lb_result = in_http.Send(ls_data)
lb_result = in_http.Send(ls_send)
If Not lb_result Then
	MessageBox("Send Error #" + &
					String(Error.Number), Error.Text, StopSign!)
	Return
End If

If in_http.ResponseText = "" Then
	ls_resp = "No response returned"
Else
	ls_resp = in_http.ResponseText
End If


//ls_resp = mid(ls_resp, p1 + 4, p1 - p2 - 4)
//clipboard(ls_resp)
openwithparm(w_sql_msg,ls_resp)
//MessageBox("Response",ls_resp)
end event

type st_pracs from statictext within w_namsspass_query
integer x = 87
integer y = 88
integer width = 1179
integer height = 76
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
boolean enabled = false
string text = "No provider selected"
boolean focusrectangle = false
end type

type cb_view from commandbutton within w_namsspass_query
integer x = 1966
integer y = 72
integer width = 489
integer height = 84
integer taborder = 70
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&View Selected"
end type

event clicked;gs_batch_search ls_b

IF UpperBound( il_pracs ) > 0 THEN
	ls_b.li_prac_id[] = il_pracs[]
	openwithparm(w_selected_prac_list,ls_b)
END IF
end event

type cb_batch from commandbutton within w_namsspass_query
integer x = 1472
integer y = 72
integer width = 489
integer height = 84
integer taborder = 60
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Batch Select"
end type

event clicked;openwithparm(w_batch_prac_select_new, "R" )

if message.stringparm = "Cancel" then return

ist_search = message.powerobjectparm
il_pracs[] = ist_search.li_prac_id[]
is_prac_names[] = ist_search.ls_name[]

st_pracs.Text = String( UpperBound( il_pracs[] ) ) + " Practitioners selected."

IF UpperBound( il_pracs ) > 0 THEN
	cb_run.Enabled = True
END IF

 

end event

type cb_prac from commandbutton within w_namsspass_query
integer x = 942
integer y = 72
integer width = 526
integer height = 84
integer taborder = 50
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Select Provider"
end type

event clicked;Integer li_nr
Integer li_find
Long ll_prac_id
String ls_full_name
long r
long rc
long i
long ic
gs_search lstr_search
gs_batch_search lst_batch

lstr_search.stran_transaction = SQLCA
lstr_search.ls_open_for = "REPORTS0" 

OpenWithParm( w_extended_search_new , lstr_search )

IF Message.DoubleParm = -1 THEN
	Return -1
END IF
debugbreak()
rc = UpperBound( il_pracs )
////ll_prac_id = Long( Mid( Message.StringParm, 1, Pos( Message.StringParm, "-" ) -1 ) )

lst_batch = message.powerobjectparm
//maha 091605 allowing for multi selection
ic = upperbound(lst_batch.li_prac_id[])
//maha app101305
for i = 1 to ic
	ll_prac_id = lst_batch.li_prac_id[i] //maha 091605
	for r = 1 to rc
		if il_pracs[r] = ll_prac_id then
			li_find = 1
			exit
		end if
	next
	IF li_find > 0 THEN
		//skip
	else
		rc++
		il_pracs[rc] = ll_prac_id
		//Start Code Change ---- 04.10.2006 #396 maha
		is_prac_names[rc] = lst_batch.ls_name[i]
		//End Code Change---04.10.2006
	END IF
next


st_pracs.Text = String( UpperBound( il_pracs[] ) ) + " Providers selected."

IF UpperBound( il_pracs ) > 0 THEN
	cb_run.Enabled = True
END IF

 

end event

type cb_2 from commandbutton within w_namsspass_query
integer x = 4064
integer y = 232
integer width = 256
integer height = 80
integer taborder = 40
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "Browse"
end type

event clicked;string ls_path 

ls_path = f_browseforfolder('Please select a Directory/Folder where you will save the export.' ,handle(parent))

if f_validstr(ls_path)  then 

sle_path.text = ls_path  +"\"

end if
end event

type st_1 from statictext within w_namsspass_query
integer x = 3694
integer y = 224
integer width = 233
integer height = 72
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 32891346
string text = "File Path:"
boolean focusrectangle = false
end type

type sle_path from singlelineedit within w_namsspass_query
integer x = 3726
integer y = 72
integer width = 1303
integer height = 92
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
borderstyle borderstyle = stylelowered!
end type

type cb_close from commandbutton within w_namsspass_query
integer x = 2871
integer y = 68
integer width = 343
integer height = 92
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Close"
end type

event clicked;Close(parent)
end event

type cb_run from commandbutton within w_namsspass_query
integer x = 2519
integer y = 68
integer width = 343
integer height = 92
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Run"
end type

event clicked;//Start Code Change ----04.08.2013 #V12 maha

Long prac_ids[]
string ls_exp_name
string ls_path
integer res
integer i
pfc_n_cst_ai_export_apb  n_export

ls_path = sle_path.text 

n_export = CREATE pfc_n_cst_ai_export_apb

n_export.is_header_rebuild = "NP"

res = n_export.of_export_data_with_text( il_export_id, il_pracs[],ls_path,0,string(ii_letter),"","",2,"" ) ////Start Code Change ----01.06.2010 #V10 maha - added param 1

destroy n_export

//messagebox("res",res)
if res < 0 then
	return -1
else
	String ls_url = "http://www.namss.org/NAMSSPASS/tabid/425/Default.aspx" 
	inet iinet_base 
	String ls_null
	
	GetContextService("Internet", iinet_base)
	if gi_citrix = 1 then
		of_open_web(ls_url)
	else
		setnull(ls_null)
		//---------Begin Modified by (Appeon)Harry 04.27.2015 for Keep Everything under One Browser--------
		//ShellExecuteA ( Handle( This ), "open", 'IEXPLORE', ls_url , ls_Null, 4)
		ShellExecuteA (Handle( This ), "open", of_getbrowserversion( ), ls_url, ls_Null, 4)
		//---------End Modfiied ------------------------------------------------------
	end if
	return 1
end if
end event

type gb_prac from groupbox within w_namsspass_query
integer x = 14
integer y = 20
integer width = 2519
integer height = 168
integer taborder = 130
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 8388608
long backcolor = 33551856
string text = "Providers"
end type

type cb_10 from commandbutton within w_namsspass_query
integer x = 3419
integer y = 968
integer width = 343
integer height = 92
integer taborder = 90
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "token file"
end type

event clicked;integer li_FileNum
string ls_url
integer p
long ll_pos1, ll_pos2, ll_pos3
string ls_source
string ls_token
string ls_auth
any la_res
inet iinet_base
n_cst_datetime lnv

ls_url = gs_temp_path + "namsspasstoken.htm"

li_FileNum = FileOpen(ls_url,   LineMode!, Write!, LockWrite!, Replace!)

FileWrite(li_FileNum,'<form name="namsspass_token"')
FileWrite(li_FileNum,'	action="https://api.namsspass.com/api/v1/token/" method="post">')
FileWrite(li_FileNum,'	<input type="hidden" name="vendor_key" value="' + is_np_vendor + '">' )
FileWrite(li_FileNum,'	<input type="hidden" name="client_key" value="' + is_np_client + '">' )
FileWrite(li_FileNum,'	<input type="hidden" name="format" value="json">' )
FileWrite(li_FileNum,	'<input type="submit" name="Submit" value="NAMSS PASS">' )
FileWrite(li_FileNum,'</form>')

FileClose(li_FileNum)

ole_browser.Object.Navigate(ls_url)
lnv.of_wait(1)
ole_browser.object.document.Forms("namsspass_token").Submit.Click

lnv.of_wait(2)

ls_source = ole_Browser.object.Document.All.Item(0).innerHTML


ll_pos1 = pos(ls_source, "vendor_key_authorized",1)

ll_pos1+= 23
ll_pos3 = pos(ls_source, ',"c',ll_pos1)
ls_auth = mid(ls_source, ll_pos1,ll_pos3 - ll_pos1)
if ls_auth <> "true" then
	messagebox("NAMSS PASS", "Vendor authorization failed:~r" + is_np_vendor )
	return 
end if

ll_pos1 = pos(ls_source, "client_key_authorized",1)
ll_pos1+= 23
ll_pos3 = pos(ls_source, '},',ll_pos1)
ls_auth = mid(ls_source, ll_pos1,ll_pos3 - ll_pos1)
if ls_auth <> "true" then
	messagebox("NAMSS PASS", "User authorization failed:~r" + is_np_client )
	return
end if


ls_token = mid(ls_source, ll_pos2,ll_pos3 - ll_pos2)

ll_pos1 = pos(ls_source, "auth_token",1)
ll_pos2 = pos(ls_source, '":"',ll_pos1)
ll_pos2+= 3
ll_pos3 = pos(ls_source, '"}]',ll_pos2)

ls_token = mid(ls_source, ll_pos2,ll_pos3 - ll_pos2)

//openwithparm(w_sql_msg,ls_source)
messagebox("token", ls_token)

return 

end event

type ole_browser from olecustomcontrol within w_namsspass_query
event statustextchange ( string text )
event progresschange ( long progress,  long progressmax )
event commandstatechange ( long command,  boolean enable )
event downloadbegin ( )
event downloadcomplete ( )
event titlechange ( string text )
event propertychange ( string szproperty )
event beforenavigate2 ( oleobject pdisp,  any url,  any flags,  any targetframename,  any postdata,  any headers,  ref boolean ab_cancel )
event newwindow2 ( ref oleobject ppdisp,  ref boolean ab_cancel )
event navigatecomplete2 ( oleobject pdisp,  any url )
event documentcomplete ( oleobject pdisp,  any url )
event onquit ( )
event onvisible ( boolean ocx_visible )
event ontoolbar ( boolean toolbar )
event onmenubar ( boolean menubar )
event onstatusbar ( boolean statusbar )
event onfullscreen ( boolean fullscreen )
event ontheatermode ( boolean theatermode )
event windowsetresizable ( boolean ab_resizable )
event windowsetleft ( long left )
event windowsettop ( long top )
event windowsetwidth ( long ocx_width )
event windowsetheight ( long ocx_height )
event windowclosing ( boolean ischildwindow,  ref boolean ab_cancel )
event clienttohostwindow ( ref long cx,  ref long cy )
event setsecurelockicon ( long securelockicon )
event filedownload ( ref boolean ab_cancel )
event navigateerror ( oleobject pdisp,  any url,  any frame,  any statuscode,  ref boolean ab_cancel )
event printtemplateinstantiation ( oleobject pdisp )
event printtemplateteardown ( oleobject pdisp )
event updatepagestatus ( oleobject pdisp,  any npage,  any fdone )
event privacyimpactedstatechange ( boolean bimpacted )
boolean visible = false
integer x = 1819
integer y = 236
integer width = 1422
integer height = 168
integer taborder = 50
boolean bringtotop = true
boolean border = false
borderstyle borderstyle = stylelowered!
boolean focusrectangle = false
string binarykey = "w_namsspass_query.win"
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
end type

event commandstatechange(long command, boolean enable);CHOOSE CASE command
CASE 1 //CSC_NAVIGATEFORWARD
	//cb_forward.enabled = enable
CASE 2 //CSC_NAVIGATEBACK
	//cb_back.enabled = enable
END CHOOSE
end event

event newwindow2(ref oleobject ppdisp, ref boolean ab_cancel);//alfee 08.11.2010

//ole_browser2.Visible = True
//ole_browser2.object.RegisterAsBrowser = True
//ppDisp =ole_browser2.object
end event

event navigatecomplete2(oleobject pdisp, any url);//code to enable back button

end event


Start of PowerBuilder Binary Data Section : Do NOT Edit
0Bw_namsspass_query.bin 
2700000a00e011cfd0e11ab1a1000000000000000000000000000000000003003e0009fffe000000060000000000000000000000010000000100000000000010000000000200000001fffffffe0000000000000000fffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffdfffffffefffffffefffffffeffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff006f00520074006f004500200074006e00790072000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000050016ffffffffffffffff0000000100000000000000000000000000000000000000000000000000000000cfdd9fd001d1578500000003000001800000000000500003004f0042005800430054005300450052004d0041000000000000000000000000000000000000000000000000000000000000000000000000000000000102001affffffff00000002ffffffff000000000000000000000000000000000000000000000000000000000000000000000000000000000000009c00000000004200500043004f00530058004f00540041005200450047000000000000000000000000000000000000000000000000000000000000000000000000000000000001001affffffffffffffff000000038856f96111d0340ac0006ba9a205d74f00000000cfdd9fd001d15785cfdd9fd001d15785000000000000000000000000004f00430054004e004e00450053005400000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000001020012ffffffffffffffffffffffff000000000000000000000000000000000000000000000000000000000000000000000000000000030000009c000000000000000100000002fffffffe0000000400000005fffffffeffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
20ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff0000004c00002025000004570000000000000000000000000000000000000000000000000000004c0000000000000000000000010057d0e011cf3573000869ae62122e2b00000008000000000000004c0002140100000000000000c0460000000000008000000000000000000000000000000000000000000000000000000000000000000000000000000001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000004c00002025000004570000000000000000000000000000000000000000000000000000004c0000000000000000000000010057d0e011cf3573000869ae62122e2b00000008000000000000004c0002140100000000000000c0460000000000008000000000000000000000000000000000000000000000000000000000000000000000000000000001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
1Bw_namsspass_query.bin 
End of PowerBuilder Binary Data Section : No Source Expected After This Point
