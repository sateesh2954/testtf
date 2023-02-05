resource "ibm_is_security_group" "sg" {
  name        = "my-security-group"
  vpc         = var.vpc_name
}

resource "ibm_is_security_group_rule" "sg_rule" {
  security_group = ibm_is_security_group.sg.id
  direction      = "ingress"
  remote         = "0.0.0.0/0"
  protocol       = "tcp"
  port_min       = 22
  port_max       = 22
}
