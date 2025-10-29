#!/bin/bash
# Update instance
yum update -y

# Install Apache
yum install -y httpd

# Start Apache and enable on startup
systemctl start httpd
systemctl enable httpd

# Get some instance metadata
INSTANCE_ID=$(curl http://169.254.169.254/latest/meta-data/instance-id)
PUBLIC_IP=$(curl http://169.254.169.254/latest/meta-data/public-ipv4)
AMI_ID=$(curl http://169.254.169.254/latest/meta-data/ami-id)

# Create a beautiful welcome page
cat <<EOF > /var/www/html/index.html
<html>
  <head>
    <title>Welcome to your First EC2 Instance!</title>
    <style>
      body { background-color: #f0f9ff; font-family: Arial, sans-serif; color: #333; }
      .card { margin: 80px auto; max-width: 420px; background: white; border-radius: 20px;
        box-shadow: 0 4px 20px rgba(0,0,0,0.1); padding: 36px; }
      h1 { color: #3b5998; }
      .meta { margin-top: 22px; padding: 10px; background: #eee; border-radius: 6px; }
      .meta span { font-weight: bold; color: #444; }
    </style>
  </head>
  <body>
    <div class="card">
      <h1>🚀 Hello, Cloud Explorer!</h1>
      <p>Congratulations! Your EC2 instance is up and running.</p>
      <div class="meta">
        <div><span>Instance ID:</span> ${INSTANCE_ID}</div>
        <div><span>Public IP:</span> ${PUBLIC_IP}</div>
        <div><span>AMI ID:</span> ${AMI_ID}</div>
      </div>
      <p style="margin-top:20px;">Created with your first AWS EC2 launch 🎉</p>
    </div>
  </body>
</html>
EOF

# Done!
