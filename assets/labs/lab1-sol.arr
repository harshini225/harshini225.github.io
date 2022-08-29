#lab01-15 SOLUTION
# === Task: convert java to pyret ===
data Activity:
  | course(dept :: String, num :: Number, prof :: String, credits :: Number)
  | indepStudy(advisor :: String, credits :: Number)
end

data Student: student(name :: String, taking :: List<Activity>) end

all-students = [list: ]
all-courses = [list: ]

# === Task: 6 courses ===
visa-2320 = course(“VISA”, 2320, “Alex Ryan”, 1)
colt-0010 = course(“COLT”, 10, “Ricky Chau”, 0.5)
engl-9000 = course(“ENGL”, 9000, “Brendan Ho”, 1)
csci-0200 = course(“CSCI”, 200, “Kathi Fisler”, 1)
visa-0100= course(“VISA”, 100, “Daniel Stupar”, 1)
engl-0100 = course(“ENGL”, 100, “Brendan Ho”, 1)

all-courses = [list: visa-2320, colt-0010, engl-9000, csci-0200, visa-0100, engl-0100]

# === Task: 3 independent studies ===
isp-austin = indepStudy(“Austin Miles”, 1)
isp-daniel = indepStudy(“Daniel Segel”, 2)
isp-truman = indepStudy(“Truman Cunningham”, 2)

all-isps = [list: isp-austin, isp-daniel, isp-truman]

# === Task: 3 students with activities ===
raphael = student(“Raphael”, [list: visa-2320, visa-0100, isp-daniel, isp-austin])
alyssa = student(“Alyssa”, [list: colt-0010, csci-0200, visa-2320])
cindy = student(“Cindy”, [list: visa-0100, engl-9000, engl-0100, isp-truman])

all-students = [list: raphael, alyssa, cindy]

# ==== get-visa-students ====
# helper function
fun contains-visa-100(activity-list :: List<Activity>) -> Boolean:
  doc: "returns a boolean of whether the input activity list contains VISA100"
  cases (List<Activity>) activity-list:
    | empty => false
    | link(f, r) => 
      cases (Activity) f: 
        | course(d, n, _, _) => (((d == "VISA") and (n == 100)) or contains-visa-100(r))
        | indepStudy(_, _) => contains-visa-100(r)
      end
  end
end

# solution with filter
fun get-visa-students(student-list :: List<Student>) -> List<Student>:
  doc: "returns a list of all students taking VISA0100 from the input student-list"
  student-list.filter(lam(stdnt): contains-visa-100(stdnt.taking) end)
where:
  get-visa-students(all-students) is [list: raphael, cindy]
end

# solution with recursion
fun get-visa-students(student-list :: List<Student>) -> List<Student>:
  doc: "returns a list of all students taking VISA0100 from the input student-list"
  cases (List<Student>) student-list:
    | empty => empty
    | link(f, r) => 
      if contains-visa-100(f.taking): 
        link(f, get-visa-students(r))
      else:
        get-visa-students(r)
      end
  end
where:
  get-visa-students(all-students) is [list: raphael, cindy]
end


# ==== find-course ====
fun find-course-helper(courses :: Activity, department :: String, number :: Number) -> Boolean:
  doc: "returns whether or not the course is in the same department and number in boolean form"
  cases (Activity) courses:
    | noInfo => false
    | course(dept, num, a, b) => (dept == department) and (num == number)
    | indepStudy(a, b) => false
  end
where:
  find-course-helper(visa-2320, "VISA", 2320) is true
  find-course-helper(visa-2320, "FJDD", 2320) is false
  find-course-helper(visa-2320, "VISA", 2322) is false
end

fun find-course(activity-list :: List<Activity>, department :: String, number :: Number) -> List<Activity>:
  doc: "returns a list containing the corresponding course object given a department code string and a course number"
  activity-list.filter(lam(w): find-course-helper(w, department, number) end)
where:
  find-course(all-courses, "VISA", 0100) is [list: visa-0100]
  find-course(all-courses, "COLT", 0010) is [list: colt-0010]
  find-course(all-courses, "VISA", 0200) is empty
end


# ==== get-isp-profs ====
fun get-isp-profs(activity-list :: List<Activity>) -> List<String>:
 doc: “returns a list of strings of all professors supervising ISPs”
	activity-list.filter(lam(w): filter-advisor(w) end).map(lam(isp): isp.advisor end)	
end

fun filter-advisor(course :: Activity) -> Boolean:
cases (Activity) cour: 
| course(dept :: String, num :: Number, prof :: String, credits :: Number) => false
  	| indepStudy(advisor :: String, credits :: Number) => true
	end
end

# ==== increase-credits ====
visa-2320-update = course("VISA", 2320, "Alex Ryan", 1.5)
engl-9000-update = course("ENGL", 9000, "Brendan Ho", 1.5)
not-all-courses = [list: colt-0010, csci-0200, visa-0100, engl-0100]
all-courses-update = [list: visa-2320-update, colt-0010, engl-9000-update, csci-0200, visa-0100, engl-0100]

fun increase-credits(activity-list :: List<Activity>) -> List<Activity>:
  doc: "returns a new copy of activity-list in which all courses numbered 2000 and above in the input-course list are now worth 1.5 credits"
  activity-list.map(lam(cour): 
      cases(Activity) cour:
        | course(dept, num, prof, credits) => 
          if num >= 2000: 
            course(dept, num, prof, 1.5)
          else:
            course(dept, num, prof, credits)
          end
        | indepStudy(a, b) => indepStudy(a, b)
      end
    end
    )
where:
  increase-credits(all-courses) is all-courses-update
  increase-credits(not-all-courses) is not-all-courses
end


# ==== replace-prof ====
fun replace-prof(activity-list :: List<Activity>) -> List<Activity>:
  doc: “returns a new copy of activity-list where the courses taught by Brendan Ho in the input course list are now taught by Qinan Yu”
	activity-list.map(lam(w): w.change-prof(w) end)
end

fun change-prof(cour :: Activity) -> Activity:
	cases (Activity) cour:
	| cour(dept :: String, num :: Number, prof :: String, credits :: Number) => 
		if (cour.prof == “Brendan Ho”):
			course(cour.dept, cour.num, “Qinan Yu”, cour.credits)
		else:
			course(cour.dept, cour.num, cour.prof, cour.credits)
		end
  	| indepStudy(advisor :: String, credits :: Number) => 
		indepStudy(cour.advisor, cour.credits)
	end
end	


# ==== Recursion Practice ====

#|
   concat-all
   (check block is below the function definition
|#

fun concat-all(letter-lst :: List<String>) -> String:
  cases(List) letter-lst:
    | empty => ""
    | link(fst, rst) => string-append(fst, concat-all(rst))
  end
end

check:
  concat-all([list: "n", "s", "y", "n", "c"]) is "nsync"
  #                             string-apend("n", "sync")
  #          string-append("n", concat-all([list: "s", "y", "n", "c"])
  
  concat-all(     [list: "s", "y", "n", "c"]) is  "sync"
  #                             string-append("s", "ync")
  #           string-append("s", concat-all([list: "y", "n", "c"])
  
  concat-all(          [list: "y", "n", "c"]) is   "ync"
  #                              string-append("y", "nc")
  #        string-append("y", concat-all([list: "n", "c"])
  
  concat-all(               [list: "n", "c"]) is    "nc"
  #                              string-append("n", "c")
  #            string-append("n", concat-all([list: "c"])
  
  concat-all(                    [list: "c"]) is     "c"
  #                                    string-append("c", "")
  #                                    string-append("c", concat-all(empty))
  concat-all(                          empty) is      ""
end

#|
   below-5
   (check block is below the function definition)
|#

fun below-5(num-lst :: List<Number>) -> List<Number>:
  cases(List) num-lst:
    | empty => empty
    | link(fst, rst) =>
      if fst < 5:
        link(fst, below-5(rst))
      else:
        below-5(rst)
      end
  end
end

#|
 the thing to remember about this check block is that we always
   write the upper example in terms of the one *immediately* below it
   (students might not have the same notes tha say "do not link first element;"
   we are making it explicit here
|#

check:
  below-5([list: 5, -2, 6, 4, 4, 11]) is [list: -2, 4, 4]
  #                                      [list: -2, 4, 4] (do not link first element)
  #                              below-5([list: -2, 6, 4, 4, 11])
  
  below-5(   [list: -2, 6, 4, 4, 11]) is [list: -2, 4, 4]
  #                                 link(-2, [list: 4, 4])
  #                         link(-2, below-5([list: 6, 4, 4, 11]))
  
  below-5(       [list: 6, 4, 4, 11]) is     [list: 4, 4]
  #                                          [list: 4, 4] (do not link first element)
  #                                  below-5([list: 4, 4, 11])
  
  below-5(          [list: 4, 4, 11]) is     [list: 4, 4]
  #                                  link(4, [list: 4])
  #                          link(4, below-5([list: 4, 11])
  
  below-5(             [list: 4, 11]) is        [list: 4]
  #                                            link(4, empty)
  #                                    link(4, below-5([list: 11])
  
  below-5(                [list: 11]) is                 empty
  #                                             (do not link first element)
  #                                              below-5(empty)
  
  below-5(                     empty) is                 empty
end

#|
   all-profs
   (check block is below the function definition)
|#

fun all-profs(activity-lst :: List<Activity>) -> List<String>:
  cases(List) activity-lst:
    | empty => empty
    | link(fst-activity, rst) =>
      cases(Activity) fst-activity:
        | course(dept, num, prof, credits) => link(prof, all-profs(rst))
        | indepStudy(advisor, credits) => link(advisor, all-profs(rst))
      end
  end
end

check:
  all-profs([list: visa-2320, isp-daniel, engl-9000, csci-0200]) is [list: "Alex Ryan", "Daniel Segel", "Brendan Ho", "Kathi Fisler"]
  #                                                            link("Alex Ryan", [list: "Daniel Segel", "Brendan Ho", "Kathi Fisler"])
  #                                                         link(visa-2320.prof, all-profs([list: isp-daniel, engl-010, csci-0200]))
  all-profs(           [list: isp-daniel, engl-9000, csci-0200]) is              [list: "Daniel Segel", "Brendan Ho", "Kathi Fisler"]
  #                                                                         link("Daniel Segel", [list: "Brendan Ho", "Kathi Fisler"])
  #                                                                     link(isp-daniel.advisor, all-profs([list: engl-010, csci-0200]))
  all-profs(                       [list: engl-9000, csci-0200]) is                              [list: "Brendan Ho", "Kathi Fisler"]
  #                                                                                         link("Brendan Ho", [link: "Kathi Fisler"])
  #                                                                                       link(engl-9000.prof, all-profs([list: csci-0200]))
  all-profs(                                  [list: csci-0200]) is                                            [list: "Kathi Fisler"]
  #                                                                                                   link("Kathi Fisler", empty)
  #                                                                                                   link(csci-0200.prof, all-profs(empty))
  all-profs(                                              empty) is                                                        empty
end
