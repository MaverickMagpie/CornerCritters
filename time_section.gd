extends PanelContainer

@onready var clock_text: RichTextLabel = $TimeMargin/TimeVBox/ClockHBox/ClockText
@onready var clock_icon: TextureRect = $TimeMargin/TimeVBox/ClockHBox/ClockIcon
@onready var calendar_text: RichTextLabel = $TimeMargin/TimeVBox/CalendarText

# Time icons
const SUN_ICON = preload("uid://b1p6bl8ih8ciw")
const MOON_ICON = preload("uid://bwjlim6t1k1hr")

func _ready() -> void:
	calendar_text.text = create_date_string()

func _process(_delta: float) -> void:
	# Update clock with time
	var time = Time.get_time_dict_from_system()
	clock_text.text = create_time_string()
	# Change date at midnight
	if time.hour == 24:
		calendar_text.text = create_date_string()
	# Change icon depending on time
	if time.hour >= 6 and time.hour < 20:
		clock_icon.texture = SUN_ICON
	else:
		clock_icon.texture = MOON_ICON

# Create a string of the current time in HOUR:MINUTES MERIDIEM format
# Example: 5:59PM
func create_time_string() -> String:
	var time = Time.get_time_dict_from_system()
	var time_meridiem = "AM"
	if time.hour > 12:
		time.hour -= 12
		time_meridiem = "PM"
	return "%d:%02d%s" % [time.hour, time.minute, time_meridiem]

# Create a string of today's date in WEEKDAY, MONTH DAY SUFFIX, YEAR format
# Example: Saturday, June 13th, 2026
func create_date_string() -> String:
	var today = Time.get_date_dict_from_system()
	var weekday = weekday_to_string(today.weekday)
	var month = month_to_string(today.month)
	var weekday_suffix = get_ordinal_suffix(today.day)
	return "%s, %s %s%s, %s" % [weekday, month, today.day, weekday_suffix, today.year]

# Get weekday string from weekday integer
func weekday_to_string(weekday: int) -> String:
	match weekday:
		Time.WEEKDAY_SUNDAY:
			return "Sunday"
		Time.WEEKDAY_MONDAY:
			return "Monday"
		Time.WEEKDAY_TUESDAY:
			return "Tuesday"
		Time.WEEKDAY_WEDNESDAY:
			return "Wednesday"
		Time.WEEKDAY_THURSDAY:
			return "Thursday"
		Time.WEEKDAY_FRIDAY:
			return "Friday"
		Time.WEEKDAY_SATURDAY:
			return "Saturday"
		_:
			return "Error"

# Get string month from integer month
func month_to_string(month: int) -> String:
	match month:
		Time.MONTH_JANUARY:
			return "January"
		Time.MONTH_FEBRUARY:
			return "February"
		Time.MONTH_MARCH:
			return "March"
		Time.MONTH_APRIL:
			return "April"
		Time.MONTH_MAY:
			return "May"
		Time.MONTH_JUNE:
			return "June"
		Time.MONTH_JULY:
			return "July"
		Time.MONTH_AUGUST:
			return "August"
		Time.MONTH_SEPTEMBER:
			return "September"
		Time.MONTH_OCTOBER:
			return "October"
		Time.MONTH_NOVEMBER:
			return "November"
		Time.MONTH_DECEMBER:
			return "December"
		_:
			return "Error"

# Return ordinal suffix calculated from integer day
func get_ordinal_suffix(day: int) -> String:
	var strDay = str(day)
	# Special case for the 11th, 12th and 13th
	if strDay.length() >= 2:
		if strDay.substr(strDay.length() - 2, 2).contains("11") or \
			strDay.substr(strDay.length() - 2, 2).contains("12") or \
			strDay.substr(strDay.length() - 2, 2).contains("13"):
				return "th"
	# All other days
	if strDay.substr(strDay.length() - 1, 1).contains("1"):
		return "st"
	elif strDay.substr(strDay.length() - 1, 1).contains("2"):
		return "nd"
	elif strDay.substr(strDay.length() - 1, 1).contains("3"):
		return "rd"
	else:
		return "th"
