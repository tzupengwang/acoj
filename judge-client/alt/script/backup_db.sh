rm ./backup/db.sql
mysqldump -u acoj -pyaxShodacGabGerveecByctEemIsijot --max_allowed_packet=1024M acoj >./backup/db.sql
