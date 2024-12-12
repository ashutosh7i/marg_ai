import CompletedExamCard from "@/components/teacher/assessments/CompletedExamCard";
import UpcomingExamCard from "@/components/teacher/assessments/UpcomingExamCard";
import Sidebar from "@/components/teacher/Sidebar";
import { assessmentsData } from "@/data/data";
import Header from "@/components/teacher/HeaderWithoutSearch";

function AssessmentsPage() {
  const getAssessmentLink = (type) => {
    switch (type) {
      case "Objective":
        return "/teacher/assessments/add-mcq";
      case "Subjective":
        return "/teacher/assessments/add-descriptive";
      case "Viva":
        return "/teacher/assessments/add-viva";
      default:
        return "#";
    }
  };

  return (
    <>
      <Sidebar />
      <Header title="Assessments" />

      <main className="ml-[16.975rem] bg-[#F3F4FF] px-10 py-6 pb-8">
        <div className="flex items-center justify-between mb-4">
          <h2 className="text-[#303972] text-2xl font-bold">Scheduled: </h2>
          <button className="text-[#4D44B5] text-sm font-bold">See all</button>
        </div>

        <div className="grid grid-cols-3 gap-4 mb-8">
          {assessmentsData.map(
            (a) =>
              new Date() < new Date(a.endDate) && (
                <UpcomingExamCard
                  key={a.id}
                  assessment={a}
                  link={getAssessmentLink(a.type)}
                />
              )
          )}
        </div>

        <div className="flex items-center justify-between mb-4">
          <h2 className="text-[#303972] text-2xl font-bold">Ended: </h2>
          <button className="text-[#4D44B5] text-sm font-bold">See all</button>
        </div>

        <div className="grid grid-cols-3 gap-4 mb-4">
          {assessmentsData.map(
            (a) =>
              new Date() > new Date(a.endDate) && (
                <CompletedExamCard
                  key={a.id}
                  assessment={a}
                  link={getAssessmentLink(a.type)}
                />
              )
          )}
        </div>
      </main>
    </>
  );
}

export default AssessmentsPage;
