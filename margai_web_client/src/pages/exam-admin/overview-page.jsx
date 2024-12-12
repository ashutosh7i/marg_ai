import Sidebar from "@/components/exam-admin/Sidebar";
import SchoolCalendar from "@/components/SchoolCalendar";
import LanguageSelector from "@/components/teacher/LanguageSelector";
import TeacherAvatar from "@/components/teacher/TeacherAvatar";
import { examSchedule } from "@/data/data";
import { ordinalDate } from "@/utils/ordinalDate";

function OverviewPage() {
  return (
    <>
      <Sidebar />
      <header className="ml-[16.975rem] flex items-center justify-between bg-[#F3F4FF] px-10 py-6">
        <h1 className="text-4xl font-bold text-[#303972]">Overview</h1>
        <div className="flex items-center gap-12">
          <LanguageSelector />
          <TeacherAvatar />
        </div>
      </header>
      <main className="ml-[16.975rem] bg-[#F3F4FF] px-10 py-6 grid grid-cols-2 gap-4">
        <div>
          <div className="grid h-[10.9375rem] grid-cols-[60%_40%] rounded-[1.25rem] bg-[#1B2E59] p-1 text-white mb-4">
            <div className="flex flex-col justify-center px-10">
              <h2 className="text-2xl font-bold">Hello, Name! 👋</h2>

              <p className="text-[0.9375rem] font-normal">
                Monitor 5 ongoing assessments or add schedule of upcoming
                assessments.
              </p>
            </div>

            <img
              src="img/admin-overview-banner.png"
              alt="banner"
              width={1040}
              height={780}
              className="translate-y-[0.5rem]"
            />
          </div>
          <div className="w-full rounded-3xl border bg-white p-6 shadow-md">
            <h2 className="text-2xl font-bold text-[#1B2E59] mb-4">
              Exam Schedules
            </h2>

            <ul className="flex flex-col gap-4">
              {examSchedule.map((exam) => (
                <li
                  className="flex items-center justify-between rounded-xl bg-[#E2EBFF] p-6 shadow-sm transition-all hover:shadow-md"
                  key={exam.id}
                >
                  <div className="flex flex-col items-start">
                    <h3 className="mb-1 text-xl font-bold text-[#333]">
                      {exam.title}
                    </h3>
                    <button className="line-clamp-1 cursor-pointer text-xs font-semibold text-[#1B2E59] underline">
                      View Schedule
                    </button>
                  </div>
                  <div className="flex flex-col gap-2">
                    <p className="text-[#8A8A8A] font-bold text-xs">
                      From {ordinalDate(exam.date)}
                    </p>
                    <p className="text-[#8A8A8A] font-bold text-xs">Class X</p>
                  </div>
                </li>
              ))}
            </ul>
          </div>
        </div>

        <SchoolCalendar
          events={{
            "2024-11-15": "TEST",
            "2024-11-20": "ASSIGNMENT",
          }}
          headingClass="text-[#1B2E59]"
        />
      </main>
    </>
  );
}

export default OverviewPage;
