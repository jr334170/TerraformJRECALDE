resource "aws_security_group" "instance" {
  name   = "${var.name}-instance-sg"
  vpc_id = var.vpc_id

  ingress {
    from_port       = 80
    to_port         = 80
    protocol        = "tcp"
    security_groups = [var.alb_security_group_id]
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = var.allowed_ssh_cidrs
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = var.allowed_egress_cidrs
  }
}

resource "aws_launch_template" "main" {
  name_prefix            = "${var.name}-lt-"
  image_id               = var.ami_id
  instance_type          = var.instance_type
  key_name               = var.key_name
  vpc_security_group_ids = [aws_security_group.instance.id]

    user_data = base64encode(<<-EOF
    #!/bin/bash
    yum update -y
    yum install -y httpd mariadb
    systemctl enable --now httpd

    HOSTNAME=$(hostname -f)
    DB_HOST="${var.db_host}"
    DB_NAME="${var.db_name}"
    DB_USER="${var.db_username}"
    DB_PASS="${var.db_password}"

    if mysql -h "$DB_HOST" -u "$DB_USER" -p"$DB_PASS" -e "SELECT 1;" "$DB_NAME" >/dev/null 2>&1; then
      DB_STATUS="OK - conectado a $DB_HOST"
    else
      DB_STATUS="ERROR - no se pudo conectar a $DB_HOST"
    fi

    echo "<h1>Hello from $HOSTNAME</h1>"  > /var/www/html/index.html
    echo "<p>DB: $DB_STATUS</p>"         >> /var/www/html/index.html
  EOF
  )

  tag_specifications {
    resource_type = "instance"
    tags          = { Name = var.name }
  }
}

resource "aws_autoscaling_group" "main" {
  name                = "${var.name}-asg"
  vpc_zone_identifier = var.subnet_ids
  target_group_arns   = var.target_group_arns
  health_check_type   = "ELB"
  min_size            = var.min_size
  max_size            = var.max_size
  desired_capacity    = var.desired_capacity

  launch_template {
    id      = aws_launch_template.main.id
    version = "$Latest"
  }
}
