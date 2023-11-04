;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname Day-of-Week-Finder) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor mixed-fraction #f #t none #f () #t)))
;;
;; ***************************************************
;; Day-of-Week-Finder.rkt
;; Finds the day of the week, given the date in yyyymmdd
;; ***************************************************
;;

;; Citation:
;; This algorithm, called "Zeller's congruence" was created by Christian Zeller.
;; This is his paper archived:
;; https://projecteuclid.org/journals/acta-mathematica/volume-9/issue-none/Kalender-Formeln/10.1007/BF02406733.full
;; This code below that I created uses this algorithm.


(define century->year 100) ; One century is 100 years.
  

;; This helper function takes in full date (yearmmdd), returns its day of the month (dd).
(define (day-of-month date)
  (modulo date 100))

;; This helper function takes in full date (yearmmdd), returns its month of the year (mm).
(define (month-of-year date)
  (/ (- (modulo date 10000) (day-of-month date)) 100))

;; This helper function takes in, full date (yearmmdd), returns only its month of the year (year).
(define (year-of-date date)
  (/ (- date (* (month-of-year date) 100) (day-of-month date)) 10000))

;; Formula requires January and February to be 13 and 14 respectively (rather than months 1 and 2)
;; This helper function converts if needed.
(define (month-for-formula date)
  (cond [(= (month-of-year date) 1) 13]
        [(= (month-of-year date) 2) 14]
        [else (month-of-year date)]))

;; If January or February is changed to be 13 or 14 respectively (rather than months 1 and 2),
;; Formula then needs year to be subtracted by one.
;; This helper function does this if needed.
(define (year-for-formula date)
  (cond [(<= (month-of-year date) 2) (- (year-of-date date) 1)]
        [else (year-of-date date)]))

;; This helper function contains the formula
;; (see citation for formula)
;: This helps with keeping code clean and readable.
(define (num-day-of-week date)
  (modulo (+ (day-of-month date)
             (floor (/ (* 13 (+ (month-for-formula date) 1)) 5))
             (modulo (year-for-formula date) century->year)
             (floor (/ (modulo (year-for-formula date) century->year) 4))
             (floor (/ (quotient (year-for-formula date) century->year) 4))
             (* -2 (quotient (year-for-formula date) century->year))) 7))


;; This function takes in any day, returns day of week.
;; Input as yearmmdd (dd is day of month, mm is month of year, rest is year).
(define (date->day-of-week date)
  (cond [(= (num-day-of-week date) 0) 'Saturday]
        [(= (num-day-of-week date) 1) 'Sunday]
        [(= (num-day-of-week date) 2) 'Monday]
        [(= (num-day-of-week date) 3) 'Tuesday]
        [(= (num-day-of-week date) 4) 'Wednesday]
        [(= (num-day-of-week date) 5) 'Thursday]
        [(= (num-day-of-week date) 6) 'Friday]))


;; Testing:
(check-expect (date->day-of-week 20230926) 'Tuesday)
(check-expect (date->day-of-week 38781202) 'Monday)
(check-expect (date->day-of-week 20230913) 'Wednesday)
(check-expect (date->day-of-week 20000314) 'Tuesday)
(check-expect (date->day-of-week 20170701) 'Saturday)
(check-expect (date->day-of-week 19990314) 'Sunday)
(check-expect (date->day-of-week 19760618) 'Friday)
(check-expect (date->day-of-week 29990314) 'Thursday)
(check-expect (date->day-of-week 24450417) 'Monday)
(check-expect (date->day-of-week 20010102) 'Tuesday)
(check-expect (date->day-of-week 20050423) 'Saturday)
(check-expect (date->day-of-week 17530101) 'Monday)
(check-expect (date->day-of-week 43420228) 'Saturday)
(check-expect (date->day-of-week 20000229) 'Tuesday)
(check-expect (date->day-of-week 24160229) 'Monday)

(check-expect (date->day-of-week 20050913) 'Tuesday)
(check-expect (date->day-of-week 24440701) 'Friday)
(check-expect (date->day-of-week 39900311) 'Sunday)