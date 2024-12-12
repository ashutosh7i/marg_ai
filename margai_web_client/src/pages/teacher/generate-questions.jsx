import { useState } from "react";
import Sidebar from "@/components/teacher/Sidebar";
import LanguageSelector from "@/components/teacher/LanguageSelector";
import TeacherAvatar from "@/components/teacher/TeacherAvatar";
import {
  Dialog,
  DialogContent,
  DialogHeader,
  DialogTitle,
} from "@/components/ui/dialog";
import * as Slider from "@radix-ui/react-slider";

function GenerateQuestions() {
  const [formData, setFormData] = useState({
    subject: "",
    subtopics: [],
    selectedTypes: [],
    questionCounts: {},
    difficulty: 5,
    language: "English",
    targetAudience: "",
  });

  const questionTypes = ["MCQ", "Descriptive", "MSQ", "True/False"];

  const handleSubmit = (e) => {
    e.preventDefault();

    // Format data for API
    const apiData = {
      subject: formData.subject,
      subtopics: formData.subtopics,
      type: formData.selectedTypes,
      difficulty_level:
        formData.difficulty >= 7
          ? "hard"
          : formData.difficulty >= 4
          ? "medium"
          : "easy",
      number_of_questions: formData.questionCounts,
      language: formData.language,
      target_audience: formData.targetAudience,
    };

    console.log("API Data:", apiData);
    // Send to API
  };

  return (
    <>
      <Sidebar />
      <header className="ml-[16.975rem] flex items-center justify-between bg-[#F3F4FF] px-10 py-6">
        <h1 className="text-4xl font-bold text-[#303972]">
          Generate Questions
        </h1>
        <div className="flex items-center gap-12">
          <LanguageSelector />
          <TeacherAvatar />
        </div>
      </header>

      <main className="ml-[16.975rem] min-h-screen bg-[#F3F4FF] p-10">
        <div className="max-w-2xl bg-white rounded-xl shadow-lg p-8">
          <form className="space-y-6" onSubmit={handleSubmit}>
            <div>
              <label className="block text-sm font-medium text-[#303972]">
                Subject
              </label>
              <input
                type="text"
                className="mt-1 block w-full p-2.5 border border-gray-300 rounded-lg"
                value={formData.subject}
                onChange={(e) =>
                  setFormData({ ...formData, subject: e.target.value })
                }
                placeholder="e.g. Programming in C++"
              />
            </div>

            <div>
              <label className="block text-sm font-medium text-[#303972]">
                Subtopics
              </label>
              <input
                type="text"
                className="mt-1 block w-full p-2.5 border border-gray-300 rounded-lg"
                placeholder="Enter subtopics separated by commas"
                onChange={(e) =>
                  setFormData({
                    ...formData,
                    subtopics: e.target.value
                      .split(",")
                      .map((topic) => topic.trim()),
                  })
                }
              />
            </div>

            <div>
              <label className="block text-sm font-medium text-[#303972] mb-2">
                Question Types
              </label>
              <div className="space-y-2">
                {questionTypes.map((type) => (
                  <div key={type} className="flex items-center gap-4">
                    <input
                      type="checkbox"
                      id={type}
                      checked={formData.selectedTypes.includes(type)}
                      onChange={(e) => {
                        const updatedTypes = e.target.checked
                          ? [...formData.selectedTypes, type]
                          : formData.selectedTypes.filter((t) => t !== type);
                        setFormData({
                          ...formData,
                          selectedTypes: updatedTypes,
                        });
                      }}
                    />
                    <label htmlFor={type}>{type}</label>
                    {formData.selectedTypes.includes(type) && (
                      <input
                        type="number"
                        className="w-20 p-1 border rounded"
                        placeholder="Count"
                        onChange={(e) =>
                          setFormData({
                            ...formData,
                            questionCounts: {
                              ...formData.questionCounts,
                              [type]: parseInt(e.target.value),
                            },
                          })
                        }
                      />
                    )}
                  </div>
                ))}
              </div>
            </div>

            <div>
              <label className="block text-sm font-medium text-[#303972] mb-2">
                Difficulty Level: {formData.difficulty}
              </label>
              <Slider.Root
                className="relative flex items-center select-none touch-none w-full h-5"
                value={[formData.difficulty]}
                max={10}
                min={1}
                step={1}
                onValueChange={(value) =>
                  setFormData({ ...formData, difficulty: value[0] })
                }
              >
                <Slider.Track className="bg-gray-200 relative grow rounded-full h-2">
                  <Slider.Range className="absolute bg-[#303972] rounded-full h-full" />
                </Slider.Track>
                <Slider.Thumb className="block w-5 h-5 bg-[#303972] rounded-full hover:bg-[#252d5a] focus:outline-none" />
              </Slider.Root>
            </div>

            <div>
              <label className="block text-sm font-medium text-[#303972]">
                Language of the Entire Paper
              </label>
              <select
                className="mt-1 block w-full p-2.5 border border-gray-300 rounded-lg focus:ring-2 focus:ring-[#303972] focus:border-transparent transition-all duration-200"
                value={formData.language}
                onChange={(e) =>
                  setFormData({ ...formData, language: e.target.value })
                }
              >
                <option>English</option>
                <option>Hindi</option>
                <option>Spanish</option>
                <option>French</option>
                {/* Add more languages as needed */}
              </select>
            </div>

            <div>
              <label className="block text-sm font-medium text-[#303972]">
                Target Audience for the Entire Paper
              </label>
              <input
                type="text"
                className="mt-1 block w-full p-2.5 border border-gray-300 rounded-lg focus:ring-2 focus:ring-[#303972] focus:border-transparent transition-all duration-200"
                value={formData.targetAudience}
                onChange={(e) =>
                  setFormData({ ...formData, targetAudience: e.target.value })
                }
                placeholder="Enter the target audience"
              />
            </div>

            <div className="flex justify-end gap-4 pt-6">
              <button
                type="submit"
                className="px-6 py-2.5 bg-[#303972] text-white rounded-lg hover:bg-[#252d5a] transition-colors duration-200 shadow-md hover:shadow-lg"
              >
                Generate Questions
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

export default GenerateQuestions;
