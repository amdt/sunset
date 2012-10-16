" Reference: http://williams.best.vwh.net/sunrise_sunset_algorithm.htm

let s:PI = 3.14159265359
let s:ZENITH = 90
let g:sunset_latitude = 51.78
let g:sunset_longitude = -1.483
let g:sunset_utc_offset = 1

function s:calculate(sunrise_or_sunset)
	function! l:degrees_to_radians(degrees)
		return (s:PI / 180) * a:degrees
	endfunction

	function! l:radians_to_degrees(radians)
		return (180 / s:PI) * a:radians
	endfunction

	function! s:minutes_from_decimal(number)
		return float2nr(60.0 / 100 * (a:number - floor(a:number)) * 100)
	endfunction

	" 1. First calculate the day of the year
	let l:day_of_year = strftime("%j")

	" 2. Convert the longitude to hour value and calculate an approximate time
	let l:longitude_hour = g:sunset_longitude / 15

	let l:n = a:sunrise_or_sunset == "sunrise" ? 6 : 18
	let l:approximate_time = l:day_of_year + ((l:n - l:longitude_hour) / 24)

	" 3. Calculate the Sun's mean anomaly
	let l:mean_anomaly = (0.9856 * l:approximate_time) - 3.289

	" 4. Calculate the Sun's true longitude
	let l:true_longitude =
				\ l:mean_anomaly +
				\ (1.916 * sin(l:degrees_to_radians(l:mean_anomaly))) +
				\ (0.020 * sin(l:degrees_to_radians(2) * l:degrees_to_radians(l:mean_anomaly))) +
				\ 282.634
	
	if l:true_longitude < 0
		let l:true_longitude = l:true_longitude + 360
	elseif l:true_longitude >= 360
		let l:true_longitude = l:true_longitude - 360
	endif
	
	" 5a. Calculate the Sun's right ascension
	let l:right_ascension =
				\ l:radians_to_degrees(atan(0.91764 * tan(l:degrees_to_radians(l:true_longitude))))

	if l:right_ascension < 0
		let l:right_ascension = l:right_ascension + 360
	elseif l:right_ascension >= 360
		let l:right_ascension = l:right_ascension - 360
	endif
	
	" 5b. Right ascension value needs to be in the same quadrant as
	" l:true_longitude
	let l:true_longitude_quadrant = (floor(l:true_longitude / 90)) * 90
	let l:right_ascension_quadrant = (floor(l:right_ascension / 90)) * 90
	let l:right_ascension = l:right_ascension +
				\ (l:true_longitude_quadrant - l:right_ascension_quadrant)

	" 5c. Right ascension value needs to be converted into hours
	let l:right_ascension = l:right_ascension / 15

	" 6. Calculate the Sun's declination
	let l:sin_declination =
				\ 0.39782 *
				\ sin(l:degrees_to_radians(l:true_longitude))
	let l:cos_declination =
				\ cos(asin(l:degrees_to_radians(l:sin_declination)))

	" 7a. Calculate the Sun's local hour angle
	let l:cos_hour_angle =
				\ (cos(l:degrees_to_radians(s:ZENITH)) - (l:sin_declination * sin(l:degrees_to_radians(g:sunset_latitude)))) /
				\ (l:cos_declination * cos(l:degrees_to_radians(g:sunset_latitude)))

	if l:cos_hour_angle > 1
		" the sun never rises on this location (on the specified date)
	elseif l:cos_hour_angle < -1
		" the sun never sets on this location (on the specified date)
	endif

	" 7b. Finish calculating H and convert into hours
	if a:sunrise_or_sunset == "sunrise"
		let l:hour = 360 - l:radians_to_degrees(acos(l:cos_hour_angle))
	elseif a:sunrise_or_sunset == "sunset"
		let l:hour = l:radians_to_degrees(acos(l:cos_hour_angle))
	endif

	let l:hour = l:hour / 15

	" 8. Calculate local mean time of rising/setting
	let l:mean_time =
				\ l:hour +
				\ l:right_ascension -
				\ (0.06571 * l:approximate_time) -
				\ 6.622

	" 9. Adjust back to UTC
	let l:universal_time = l:mean_time - l:longitude_hour
	
	" 10. Convert l:universal_time value to local time zone of
	" latitude/longitude
	let l:local_time = l:universal_time + g:sunset_utc_offset

	if l:local_time < 0
		let l:local_time = l:local_time + 24
	elseif l:local_time >= 24
		let l:local_time = l:local_time - 24
	endif

	let dict = {'hour': float2nr(l:local_time), 'minute': s:minutes_from_decimal(l:local_time)}
	return dict
endfunction

function g:sunset()
	let l:current_time = {'hour': strftime("%H"), 'minute': strftime("%M")}

	if (l:current_time.hour < s:sunrise.hour && l:current_time.minute < s:sunrise.minute) ||
				\ (l:current_time.hour > s:sunset.hour && l:current_time.minute > s:sunset.minute)
		set background=dark
	else
		set background=light
	endif
endfunction

let s:sunrise = s:calculate("sunrise")
let s:sunset = s:calculate("sunset")
call g:sunset()

autocmd CursorHold * nested call g:sunset()
