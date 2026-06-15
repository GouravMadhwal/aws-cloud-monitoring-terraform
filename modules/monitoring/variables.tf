variable "email_id" {
    description = "This stores the Email ID for subscribing to SNS service"
    type = string
}

variable "instance_id" {
    description = "This stores the instance ID of the web server"
    type = string
}

variable "threshold_value" {
    description = "This stores the threshold value for alarm to trigger after"
    type = number
}

variable "period_value" {
    description = "This stores the period value for how many seconds does the alarm stay for"
    type = number
}

variable "evaluation_periods_value" {
    description = "This stores the evaluation period value for how many periods does the alarm stay for. If period = 30 secs and eval period = 2, then alarm will be triggered when CPU Utilization is above defined threshold value for 30 * 2 = 60 secs."
    type = number
}