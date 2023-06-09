resource "aws_lb_target_group" "bluegreentarget1" {
  name        = "bluegreentarget1"
  target_type = "alb"
  port        = 80
  protocol    = "TCP"
  vpc_id      = module.vpc.vpc_attributes.id
}

resource "aws_lb_target_group" "bluegreentarget2" {
  name        = "bluegreentarget2"
  target_type = "alb"
  port        = 80
  protocol    = "TCP"
  vpc_id      = module.vpc.vpc_attributes.id
}
