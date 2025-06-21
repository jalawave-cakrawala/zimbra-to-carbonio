export TANGGAL=$(date +"%Y%m%d")
export PROJECT="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
export SSH_ACCOUNT="dude@192.168.200.3"
export REMOTE_DIR="/home/dude/backup_$TANGGAL"
# aktifkan jika ingin backup mailbox pada tanggal tertentu dengan format (mm/dd/yy)
# export MAILBOX_FIST_DATE="05/01/25"
# export MAILBOX_LAST_DATE="07/01/25"

$PROJECT/scripts/local-clean.sh
echo ""
$PROJECT/scripts/remote-clean.sh
echo ""
$PROJECT/scripts/domain/name.sh
echo ""
$PROJECT/scripts/domain/status.sh
echo ""
$PROJECT/scripts/email/name.sh
echo ""
$PROJECT/scripts/email/status.sh
echo ""
$PROJECT/scripts/email/password.sh
echo ""
$PROJECT/scripts/email/display_name.sh
echo ""
$PROJECT/scripts/email/given_name.sh
echo ""
$PROJECT/scripts/distribution_list/name.sh
echo ""
$PROJECT/scripts/distribution_list/forwarding_address.sh
echo ""
$PROJECT/scripts/email/mailbox.sh
echo ""
rsync -r $PROJECT/scripts $SSH_ACCOUNT:$REMOTE_DIR/scripts
rsync -r $PROJECT/restore.sh $SSH_ACCOUNT:$REMOTE_DIR/

unset TANGGAL
unset PROJECT
unset SSH_ACCOUNT
unset REMOTE_DIR
unset MAILBOX_FIST_DATE
unset MAILBOX_LAST_DATE

echo "Selesai membackup email."
