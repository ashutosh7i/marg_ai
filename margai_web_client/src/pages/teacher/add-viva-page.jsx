import { useState } from "react";
import LanguageSelector from "@/components/teacher/LanguageSelector";
import Sidebar from "@/components/teacher/Sidebar";
import TeacherAvatar from "@/components/teacher/TeacherAvatar";
import { Link } from "react-router";
import {
  Dialog,
  DialogContent,
  DialogHeader,
  DialogTitle,
} from "@/components/ui/dialog";

function AddVivaPage() {
  const [formData, setFormData] = useState({
    syllabus: "",
    questionCount: 0,
    difficulty: "Medium",
    duration: 0,
    marks: 0,
  });
  const [error, setError] = useState("");

  const handleSubmit = (e) => {
    e.preventDefault();

    // Validate all fields
    if (!formData.syllabus.trim()) {
      setError("Please enter viva syllabus");
      return;
    }
    if (!formData.questionCount || formData.questionCount <= 0) {
      setError("Please enter a valid number of questions");
      return;
    }
    if (!formData.difficulty) {
      setError("Please select difficulty level");
      return;
    }
    if (!formData.duration || formData.duration <= 0) {
      setError("Please enter valid duration");
      return;
    }
    if (!formData.marks || formData.marks <= 0) {
      setError("Please enter valid marks");
      return;
    }

    // If validation passes, proceed with submission
    console.log(formData);
    // Add your submission logic here
  };

  return (
    <>
      <Sidebar />
      <header className="ml-[16.975rem] flex items-center justify-between bg-[#F3F4FF] px-10 py-6">
        <h1 className="text-4xl font-bold text-[#303972]">Add Viva</h1>
        <div className="flex items-center gap-12">
          <LanguageSelector />
          <TeacherAvatar />
        </div>
      </header>

      <div className="ml-[16.975rem] bg-[#F3F4FF] px-10 py-6 flex gap-8">
        <div className="bg-white rounded-xl p-6 shadow-lg hover:shadow-xl transition-shadow duration-200 w-64">
          <div className="flex items-center gap-4">
            <div className="p-3 bg-[#303972] rounded-lg">
              <svg
                xmlns="http://www.w3.org/2000/svg"
                className="h-6 w-6 text-white"
                fill="none"
                viewBox="0 0 24 24"
                stroke="currentColor"
              >
                <path
                  strokeLinecap="round"
                  strokeLinejoin="round"
                  strokeWidth={2}
                  d="M12 6v6m0 0v6m0-6h6m-6 0H6"
                />
              </svg>
            </div>
            <div>
              <h2 className="text-sm font-medium text-gray-500">
                Total Questions
              </h2>
              <p className="text-3xl font-bold text-[#303972]">
                {formData.questionCount || 0}
              </p>
            </div>
          </div>
        </div>
        <div className="bg-white rounded-xl p-6 shadow-lg hover:shadow-xl transition-shadow duration-200 w-64">
          <div className="flex items-center gap-4">
            <div className="p-3 bg-[#303972] rounded-lg">
              <svg
                xmlns="http://www.w3.org/2000/svg"
                className="h-6 w-6 text-white"
                fill="none"
                viewBox="0 0 24 24"
                stroke="currentColor"
              >
                <path
                  strokeLinecap="round"
                  strokeLinejoin="round"
                  strokeWidth={2}
                  d="M12 8v4l3 3m6-3a9 9 0 11-18 0 9 9 0 0118 0z"
                />
              </svg>
            </div>
            <div>
              <h2 className="text-sm font-medium text-gray-500">
                Duration (min)
              </h2>
              <p className="text-3xl font-bold text-[#303972]">
                {formData.duration || 0}
              </p>
            </div>
          </div>
        </div>
      </div>

      <main className="ml-[16.975rem] min-h-screen bg-[#F3F4FF] p-10">
        <div className="max-w-2xl bg-white rounded-xl shadow-lg p-8">
          <form className="space-y-6" onSubmit={handleSubmit}>
            <div>
              <label className="block text-sm font-medium text-[#303972]">
                Viva Syllabus
              </label>
              <input
                type="text"
                className="mt-1 block w-full p-2.5 border border-gray-300 rounded-lg focus:ring-2 focus:ring-[#303972] focus:border-transparent transition-all duration-200"
                value={formData.syllabus}
                onChange={(e) =>
                  setFormData({ ...formData, syllabus: e.target.value })
                }
                placeholder="Enter syllabus topics"
              />
            </div>

            <div className="grid grid-cols-2 gap-6">
              <div>
                <label className="block text-sm font-medium text-[#303972]">
                  Number of Questions
                </label>
                <input
                  type="number"
                  className="mt-1 block w-full p-2.5 border border-gray-300 rounded-lg focus:ring-2 focus:ring-[#303972] focus:border-transparent transition-all duration-200"
                  value={formData.questionCount}
                  onChange={(e) =>
                    setFormData({
                      ...formData,
                      questionCount: parseInt(e.target.value),
                    })
                  }
                  min="0"
                />
              </div>

              <div>
                <label className="block text-sm font-medium text-[#303972]">
                  Marks
                </label>
                <input
                  type="number"
                  className="mt-1 block w-full p-2.5 border border-gray-300 rounded-lg focus:ring-2 focus:ring-[#303972] focus:border-transparent transition-all duration-200"
                  value={formData.marks}
                  onChange={(e) =>
                    setFormData({
                      ...formData,
                      marks: parseInt(e.target.value),
                    })
                  }
                  min="0"
                />
              </div>

              <div>
                <label className="block text-sm font-medium text-[#303972]">
                  Difficulty Level
                </label>
                <select
                  className="mt-1 block w-full p-2.5 border border-gray-300 rounded-lg focus:ring-2 focus:ring-[#303972] focus:border-transparent transition-all duration-200"
                  value={formData.difficulty}
                  onChange={(e) =>
                    setFormData({ ...formData, difficulty: e.target.value })
                  }
                >
                  <option>Easy</option>
                  <option>Medium</option>
                  <option>Hard</option>
                </select>
              </div>

              <div>
                <label className="block text-sm font-medium text-[#303972]">
                  Duration (minutes)
                </label>
                <input
                  type="number"
                  className="mt-1 block w-full p-2.5 border border-gray-300 rounded-lg focus:ring-2 focus:ring-[#303972] focus:border-transparent transition-all duration-200"
                  value={formData.duration}
                  onChange={(e) =>
                    setFormData({
                      ...formData,
                      duration: parseInt(e.target.value),
                    })
                  }
                  min="0"
                />
              </div>
            </div>

            <div className="flex justify-end gap-4 pt-6">
              <Link to="/teacher/assessments">
                <button className="px-6 py-2.5 border border-[#303972] text-[#303972] rounded-lg hover:bg-gray-50 transition-colors duration-200">
                  Cancel
                </button>
              </Link>
              <button
                type="submit"
                className="px-6 py-2.5 bg-[#303972] text-white rounded-lg hover:bg-[#252d5a] transition-colors duration-200 shadow-md hover:shadow-lg"
              >
                Create Viva
              </button>
            </div>
          </form>
        </div>
      </main>
      <Dialog open={!!error} onOpenChange={() => setError("")}>
        <DialogContent className="bg-red-100 border border-red-400 text-red-700">
          <DialogHeader>
            <DialogTitle>Error</DialogTitle>
          </DialogHeader>
          <p>{error}</p>
        </DialogContent>
      </Dialog>
    </>
  );
}

export default AddVivaPage;
