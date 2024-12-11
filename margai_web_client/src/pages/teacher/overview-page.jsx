import Sidebar from "@/components/teacher/Sidebar";
import ClassPerformanceChart from "@/components/teacher/overview/ClassPerformanceChart";
import Banner from "@/components/teacher/overview/Banner";
import Header from "@/components/teacher/Header";
import TopPerformingStudentsCard from "@/components/teacher/overview/TopPerformingStudentsCard";
import SchoolCalendar from "@/components/teacher/SchoolCalendar";
import {
  classData,
  topStudents,
  recentStudents,
  documents,
  tests,
  classProgress,
} from "@/data/data";
import RecentStudentsCard from "@/components/teacher/overview/RecentStudentsCard";
import DocumentListCard from "@/components/teacher/overview/DocumentListCard";
import TestListCard from "@/components/teacher/overview/TestListCard";
import ClassProgressCard from "@/components/teacher/overview/ClassProgressCard";

function HomePage() {
  return (
    <>
      {/**
       *
       * Side Bar
       *
       */}
      <Sidebar />

      {/**
       *
       * Main content
       *
       */}
      <div className="ml-[16.975rem] bg-[#F3F4FF]">
        <Header title="Overview" />

        <main className="mx-4 pb-8">
          {/**
           *
           * Banner
           *
           */}
          <Banner />

          {/**
           *
           * Row 1
           *
           */}
          <div className="m-4 grid grid-cols-3 gap-4 mb-8">
            {/* Chart */}
            <ClassPerformanceChart data={classData} />

            {/* Student Progress */}
            <ClassProgressCard classProgress={classProgress} />

            {/* Top Performing */}
            <TopPerformingStudentsCard students={topStudents} />
          </div>

          {/**
           *
           * Row 2
           *
           */}
          <div className="m-4 grid grid-cols-[60%_40%] gap-4 mb-8">
            {/* School Calendar */}
            <SchoolCalendar
              events={{
                "2024-11-15": "TEST",
                "2024-11-20": "ASSIGNMENT",
              }}
            />

            {/* Recent Students */}
            <RecentStudentsCard recentStudents={recentStudents} />
          </div>

          {/**
           *
           * Row 3
           *
           */}
          <div className="m-4 grid grid-cols-[1fr_2fr] gap-4">
            {/* Documents */}
            <DocumentListCard documents={documents} />

            {/* Tests */}
            <TestListCard tests={tests} />
          </div>
        </main>
      </div>

      {/* TODO: Schedule */}
    </>
  );
}

export default HomePage;
