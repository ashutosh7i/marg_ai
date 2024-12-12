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

function GenerateQuestionsPage() {
  const [formData, setFormData] = useState({
    subject: "",
    subtopics: [],
    type: [],
    difficultyLevel: 5,
    numberOfQuestions: {
      MCQs: 0,
      descriptive: 0,
    },
    language: "English",
    targetAudience: "",
  });
  const [error, setError] = useState("");
  const [isLoading, setIsLoading] = useState(false);
  const [generatedQuestions, setGeneratedQuestions] = useState(null);

  const handleSubmit = async (e) => {
    e.preventDefault();

    // Validate all fields
    if (!formData.subject.trim()) {
      setError("Please enter the subject");
      return;
    }
    if (formData.subtopics.length === 0) {
      setError("Please enter subtopics");
      return;
    }
    if (!formData.language.trim()) {
      setError("Please select the language");
      return;
    }
    if (!formData.targetAudience.trim()) {
      setError("Please enter the target audience");
      return;
    }

    // Format data for submission
    const formattedData = {
      subject: formData.subject,
      subtopics: formData.subtopics,
      type: ["MCQ", "descriptive"], // Hardcoded question types
      "difficulty level": `${formData.difficultyLevel} on 10`,
      "number of questions": formData.numberOfQuestions,
      language: formData.language,
      "target audience": formData.targetAudience,
    };

    console.log("Formatted data:", formattedData);

    setIsLoading(true);
    setGeneratedQuestions(""); // Clear previous results

    try {
      const response = await fetch(
        "https://himmaannsshhuu-langflow.hf.space/api/v1/run/6739c578-ae8f-4475-962d-af0f0cf33f2d?stream=false",
        {
          method: "POST",
          headers: {
            Authorization: "Bearer <TOKEN>",
            "Content-Type": "application/json",
            "x-api-key": "<your api key>",
          },
          body: JSON.stringify({
            input_value: JSON.stringify(formattedData),
            output_type: "chat",
            input_type: "chat",
            tweaks: {
              "ChatInput-B0syb": {},
              "Prompt-1hx2Q": {},
              "ChatOutput-UYiOG": {},
              "OpenAIModel-bCclS": {},
              "Memory-fpa94": {},
            },
          }),
        }
      );

      const data = await response.json();
      const questions = data?.outputs?.[0]?.outputs?.[0]?.artifacts?.message;
      console.log(questions);

      if (!questions) {
        throw new Error("Invalid response format");
      }

      const parsedQuestions = JSON.parse(questions);
      setGeneratedQuestions(parsedQuestions);
    } catch (error) {
      console.error("Error:", error);
      setError("Failed to generate questions. Please try again.");
    } finally {
      setIsLoading(false);
    }

    console.log("Formatted data:", formattedData);
  };

  const renderQuestion = (question) => {
    if (question.type === "MCQ") {
      return (
        <div key={question["question id"]} className="mb-4">
          <p className="font-semibold">{question["question prompt"]}</p>
          <ul className="list-disc pl-5">
            {question.options.map((option, index) => (
              <li key={index}>{option}</li>
            ))}
          </ul>
        </div>
      );
    } else if (question.type === "descriptive") {
      return (
        <div key={question["question id"]} className="mb-4">
          <p className="font-semibold">{question["question prompt"]}</p>
          <ul className="list-disc pl-5">{question["grading criteria"]}</ul>
        </div>
      );
    }
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
                className="mt-1 block w-full p-2.5 border border-gray-300 rounded-lg focus:ring-2 focus:ring-[#303972] focus:border-transparent transition-all duration-200"
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
                className="mt-1 block w-full p-2.5 border border-gray-300 rounded-lg focus:ring-2 focus:ring-[#303972] focus:border-transparent transition-all duration-200"
                onChange={(e) =>
                  setFormData({
                    ...formData,
                    subtopics: e.target.value.split(",").map((s) => s.trim()),
                  })
                }
                placeholder="Enter subtopics separated by commas"
              />
            </div>

            <div>
              <label className="block text-sm font-medium text-[#303972]">
                Difficulty Level (1-10)
              </label>
              <input
                type="range"
                min="1"
                max="10"
                className="mt-1 block w-full"
                value={formData.difficultyLevel}
                onChange={(e) =>
                  setFormData({
                    ...formData,
                    difficultyLevel: parseInt(e.target.value),
                  })
                }
              />
              <span className="text-sm">{formData.difficultyLevel}/10</span>
            </div>

            <div>
              <label className="block text-sm font-medium text-[#303972]">
                Number of Questions
              </label>
              <div className="space-y-2">
                <div>
                  <label className="text-sm">MCQs:</label>
                  <input
                    type="number"
                    className="ml-2 w-20 p-1 border rounded"
                    onChange={(e) =>
                      setFormData({
                        ...formData,
                        numberOfQuestions: {
                          ...formData.numberOfQuestions,
                          MCQs: parseInt(e.target.value),
                        },
                      })
                    }
                  />
                </div>
                <div>
                  <label className="text-sm">Descriptive:</label>
                  <input
                    type="number"
                    className="ml-2 w-20 p-1 border rounded"
                    onChange={(e) =>
                      setFormData({
                        ...formData,
                        numberOfQuestions: {
                          ...formData.numberOfQuestions,
                          descriptive: parseInt(e.target.value),
                        },
                      })
                    }
                  />
                </div>
              </div>
            </div>

            <div>
              <label className="block text-sm font-medium text-[#303972]">
                Language of the Entire Paper
              </label>
              <select
                className="mt-1 block w-full p-2.5 border border-gray-300 rounded-lg focus:ring-2 focus:ring-[#303972] focus:border-transparent transition-all duration-200"
                value={formData.language}
                onChange={(e) => {
                  console.log({ ...formData, language: e.target.value });

                  setFormData({ ...formData, language: e.target.value });
                }}
              >
                <option value="English">English</option>
                <option value="Hindi">Hindi</option>
                <option value="Malayalam">Malayalam</option>
                <option value="Marathi">Marathi</option>
                <option value="Telugu">Telugu</option>
                <option value="Tamil">Tamil</option>
                <option value="Gujrati">Gujrati</option>
                <option value="Bengali">Bengali</option>
                <option value="Assamese">Assamese</option>
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
                disabled={isLoading}
                className={`px-6 py-2.5 bg-[#303972] text-white rounded-lg transition-colors duration-200 shadow-md hover:shadow-lg ${
                  isLoading
                    ? "opacity-50 cursor-not-allowed"
                    : "hover:bg-[#252d5a]"
                }`}
              >
                {isLoading ? "Generating..." : "Generate Questions"}
              </button>
            </div>
          </form>

          {generatedQuestions && (
            <div className="mt-8 p-6 bg-white rounded-lg border">
              <div className="flex justify-between items-center mb-6">
                <h2 className="text-lg font-semibold text-[#303972]">
                  Generated Question Paper
                </h2>
                <button
                  onClick={() => window.print()}
                  className="px-4 py-2 bg-[#303972] text-white rounded-lg hover:bg-[#252d5a] transition-colors duration-200"
                >
                  Print / Save PDF
                </button>
              </div>
              <div>
                <p>
                  <strong>Question Paper ID:</strong>{" "}
                  {generatedQuestions["question paper id"]}
                </p>
                <p>
                  <strong>Created At:</strong>{" "}
                  {new Date(generatedQuestions["created at"]).toLocaleString()}
                </p>
                <p>
                  <strong>Subject:</strong> {generatedQuestions.subject}
                </p>
                <p>
                  <strong>Subtopics:</strong>{" "}
                  {generatedQuestions.subtopics.join(", ")}
                </p>
                <p>
                  <strong>Difficulty Level:</strong>{" "}
                  {generatedQuestions["difficulty level"]}
                </p>
                <p>
                  <strong>Number of Questions:</strong>{" "}
                  {generatedQuestions["number of questions"]}
                </p>
                <div className="mt-4">
                  {generatedQuestions.questions.map((question) =>
                    renderQuestion(question)
                  )}
                </div>
              </div>
            </div>
          )}
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

export default GenerateQuestionsPage;
