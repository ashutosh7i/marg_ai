import Sidebar from "@/components/teacher/Sidebar";
import Header from "@/components/teacher/Header";
import SchoolCalendar from "@/components/teacher/SchoolCalendar";
import ScheduleCard from "@/components/teacher/events/ScheduleCard";
import UpcomingEventsCard from "@/components/teacher/events/UpcomingEventsCard";
import { upcomingExams } from "@/data/data";

function SchedulePage() {
  return (
    <>
      <Sidebar />
      <div className="ml-[16.975rem] bg-[#F3F4FF]">
        <Header title="Schedules" />
      </div>

      <main className="ml-[16.975rem] bg-[#F3F4FF] pb-6">
        <div className="mx-8 mb-4 grid grid-cols-[40%_60%] gap-4">
          {/* Today's Schedule */}
          <ScheduleCard />

          {/* School Calendar */}
          <SchoolCalendar
            events={{
              "2024-11-15": "TEST",
              "2024-11-20": "ASSIGNMENT",
            }}
          />

          {/* Upcoming Events */}
        </div>
        <UpcomingEventsCard upcomingExams={upcomingExams} />

        {/* My Calendar */}
        {/* <TeacherScheduleCalendar /> */}
      </main>
    </>
  );
}

export default SchedulePage;
