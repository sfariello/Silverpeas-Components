$senderName$ informiert Sie ein Beitrag zur Verfügung steht...
$if(senderMessage)$
<br/>Message :
"$senderMessage$"<br/> 
$endif$

Name des Beitrags : $blogName$
Datum : $blogDate$
$if(blogCategorie)$
Kategorie : $blogCategorie$
$endif$


$if(notification_receiver_users)$
Diese Nachricht wurde gesendet
 nutzer : $notification_receiver_users$
$endif$

$if(notification_receiver_groups)$
  $if(!notification_receiver_users)$
  Diese Nachricht wurde gesendet
  $endif$
 gruppen : $notification_receiver_groups$
$endif$