import Sidebar from "@/components/exam-admin/Sidebar";
import LanguageSelector from "@/components/teacher/LanguageSelector";

import TeacherAvatar from "@/components/teacher/TeacherAvatar";

const adminAssessments = [
  {
    id: 1,
    title: "Mathematics Unit 5",
    type: "Objective",
    teacherName: "Teacher Name",
    completedStudentsNum: 20,
    missingStudentsNum: 5,
    appearingStudentsNum: 5,
    endDate: "2024-12-12",
    postedOn: "2024-12-08",
    startDate: "2024-12-10",
  },
  {
    id: 2,
    title: "English Essay Writing",
    type: "Descriptive",
    teacherName: "Teacher Name",
    completedStudentsNum: 20,
    missingStudentsNum: 5,
    appearingStudentsNum: 5,
    endDate: "2024-12-13",
    postedOn: "2024-12-11",
    startDate: "2024-12-12",
  },
  {
    id: 3,
    title: "Physics",
    type: "Practical",
    teacherName: "Teacher Name",
    completedStudentsNum: 90,
    missingStudentsNum: 5,
    appearingStudentsNum: 5,
    endDate: "2024-1-12",
    postedOn: "2024-10-16",
    startDate: "2024-1-10",
  },
  {
    id: 4,
    title: "Chemistry",
    type: "Practical",
    teacherName: "Teacher Name",
    completedStudentsNum: 20,
    missingStudentsNum: 6,
    appearingStudentsNum: 67,
    endDate: "2023-12-12",
    postedOn: "2024-12-16",
    startDate: "2024-12-10",
  },
  {
    id: 5,
    title: "Social Science",
    type: "Descriptive",
    teacherName: "Teacher Name",
    completedStudentsNum: 20,
    missingStudentsNum: 0,
    appearingStudentsNum: 5,
    endDate: "2024-12-12",
    postedOn: "2024-12-16",
    startDate: "2024-12-10",
  },
  {
    id: 6,
    title: "Value Education",
    type: "Descriptive",
    teacherName: "Teacher Name",
    completedStudentsNum: 20,
    missingStudentsNum: 9,
    appearingStudentsNum: 5,
    endDate: "2024-11-12",
    postedOn: "2024-11-16",
    startDate: "2024-11-10",
  },
  {
    id: 7,
    title: "Mathematics Unit 4",
    type: "MCQ",
    teacherName: "Teacher Name",
    completedStudentsNum: 21,
    missingStudentsNum: 7,
    appearingStudentsNum: 5,
    endDate: "2025-01-12",
    postedOn: "2025-01-16",
    startDate: "2025-01-10",
  },
];

function AssignmentsPage() {
  return (
    <>
      <Sidebar />
      <div className="ml-[16.975rem] bg-[#E2EBFF] h-full pb-8">
        <header className="flex items-center justify-between px-10 py-6">
          <h1 className="text-4xl font-bold text-[#1B2E59]">Assessments</h1>

          <div className="flex items-center gap-12">
            <div className="flex items-center gap-3">
              {/* Search */}
              <input
                type="text"
                placeholder="Search here..."
                className="font-poppins h-[2.75rem] w-[21.875rem] rounded-[2.5rem] bg-[#FFF] px-6 py-0 text-base font-normal text-[#1B2E59] shadow-sm placeholder:text-sm placeholder:text-[#A098AE] focus:outline-none"
              />

              {/* Language dropdown */}
              <LanguageSelector />
            </div>

            <TeacherAvatar />
          </div>
        </header>

        <div className="px-10 pt-2">
          <div className="flex items-center justify-between mb-4">
            <h2 className="text-[#1B2E59] text-2xl font-bold">Active: </h2>
            <button className="text-[#1B2E59] text-sm font-bold">
              See all
            </button>
          </div>
          <div className="grid grid-cols-3 gap-4 mb-8">
            {adminAssessments.map(
              (a) =>
                new Date(a.startDate) < new Date() &&
                new Date(a.endDate) > new Date() && (
                  <ExamCard key={a.id} assessment={a} />
                )
            )}
          </div>

          <div className="flex items-center justify-between mb-4">
            <h2 className="text-[#1B2E59] text-2xl font-bold">Scheduled: </h2>
            <button className="text-[#1B2E59] text-sm font-bold">
              See all
            </button>
          </div>
          <div className="grid grid-cols-3 gap-4 mb-8">
            {adminAssessments.map(
              (a) =>
                new Date(a.startDate) > new Date() && (
                  <ExamCard key={a.id} assessment={a} />
                )
            )}
          </div>
        </div>
      </div>
    </>
  );
}

export default AssignmentsPage;

/* eslint-disable react/prop-types */
import { ordinalDate } from "@/utils/ordinalDate";

function ExamCard({ assessment }) {
  const {
    title,
    type,
    teacherName,
    endDate,
    postedOn,
    completedStudentsNum,
    missingStudentsNum,
    appearingStudentsNum,
    startDate,
  } = assessment;

  const status = {
    active: startDate < new Date() && endDate > new Date(),
    scheduled: startDate > new Date(),
    ended: endDate < new Date(),
  };

  return (
    <div className="bg-white rounded-3xl shadow-md px-6 py-4 flex flex-col ">
      <h2 className="text-xl font-semibold text-[#2E3A59]">{title}</h2>

      <div className="flex items-center justify-between mb-1">
        <p className="text-[#999] font-medium text-sm mb-1">Type: {type}</p>
        <p className="text-[#999] font-medium text-sm mb-1">
          By: {teacherName}
        </p>
      </div>

      <h3 className="text-[0.9rem] font-semibold text-[#8C1D18] mb-4">
        {status === "ended" ? "Finished:" : "Deadline:"}{" "}
        {ordinalDate(endDate, true)}
      </h3>

      <div className="text-center text-[#014142] text-lg font-semibold mb-3">
        {status === "scheduled" ? (
          <h3 className="">
            {Number(completedStudentsNum) +
              Number(missingStudentsNum) +
              Number(appearingStudentsNum)}
          </h3>
        ) : (
          <h3>
            Completed: {Number(completedStudentsNum)}/
            {Number(completedStudentsNum) +
              Number(missingStudentsNum) +
              Number(appearingStudentsNum)}
          </h3>
        )}

        {status === "active" ? (
          <h3>Appearing: {Number(missingStudentsNum)}</h3>
        ) : status === "scheduled" ? (
          <h3>Starts on: {ordinalDate(startDate, true)}</h3>
        ) : (
          <h3>Missing: {Number(missingStudentsNum)}</h3>
        )}
      </div>

      <button className="bg-[#1B2E59] rounded-3xl mx-6 px-3 py-2 text-white font-bold mb-2">
        {status === "active"
          ? "Details"
          : status === "scheduled"
          ? "View"
          : "View Result"}
      </button>

      <div className="text-[#AAA] text-xs text-center italic ">
        Posted: {ordinalDate(postedOn, true)}
      </div>
    </div>
  );
}
