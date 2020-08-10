APP_HOME=$(cd $(dirname $0)/..; pwd)
APP_NAME="flask-application"
APP_DESC = "Flask Application With Runtime ENV."
systemctl stop firewalld
systemctl disable firewalld
setenforce 0
tar -zxf $APP_HOME/env/2.7.tar.bz2 -C $APP_HOME/env
eval "cat <<EOF
$(< $APP_HOME/scripts/flask.service.template)
EOF
" > /usr/lib/systemd/system/${APP_NAME}.service
systemctl daemon-reload
systemctl restart ${APP_NAME}
# 设置开机自启
systemctl enable deployment-tools
echo "Installed successfully.
Please run command 'systemctl status ${APP_NAME}' for more information about service."
