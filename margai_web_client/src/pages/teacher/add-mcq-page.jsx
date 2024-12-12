import { useState } from "react";
import LanguageSelector from "@/components/teacher/LanguageSelector";
import Sidebar from "@/components/teacher/Sidebar";
import TeacherAvatar from "@/components/teacher/TeacherAvatar";
import { Link } from "react-router";
import { PlusCircleIcon, TrashIcon, PencilIcon } from "lucide-react";
import { X } from "lucide-react";
import {
  Dialog,
  DialogContent,
  DialogHeader,
  DialogTitle,
  DialogTrigger,
} from "@/components/ui/dialog";

function AddMCQPage() {
  const dummyQuestions = [
    {
      question: "What is the capital of France?",
      marks: 2,
      image: null,
      options: ["London", "Paris", "Berlin", "Madrid"],
      correctAnswer: [1], // Changed to array
    },
    {
      question:
        "Which programming language is known as the 'language of the web'?",
      marks: 3,
      image: null,
      options: ["Python", "Java", "JavaScript", "C++"],
      correctAnswer: [2],
    },
    {
      question: "What is 2 + 2?",
      marks: 1,
      image: null,
      options: ["3", "4", "5", "6"],
      correctAnswer: [1],
    },
  ];

  const [questions, setQuestions] = useState(dummyQuestions);
  const [showForm, setShowForm] = useState(false);
  const [editIndex, setEditIndex] = useState(null);
  const [currentQuestion, setCurrentQuestion] = useState({
    question: "",
    marks: 0,
    image: null,
    options: ["", ""], // Start with 2 options minimum
    correctAnswer: [], // Changed to empty array
  });
  const [error, setError] = useState("");

  const handleAddQuestion = () => {
    // Validate fields
    if (!currentQuestion.question.trim()) {
      setError("Question cannot be empty");
      return;
    }
    if (
      !currentQuestion.marks ||
      isNaN(currentQuestion.marks) ||
      currentQuestion.marks <= 0
    ) {
      setError("Please enter valid marks greater than 0");
      return;
    }
    if (currentQuestion.options.some((opt) => !opt.trim())) {
      setError("All options must be filled");
      return;
    }
    if (currentQuestion.correctAnswer.length === 0) {
      setError("Please select at least one correct answer");
      return;
    }

    if (editIndex !== null) {
      const updatedQuestions = [...questions];
      updatedQuestions[editIndex] = currentQuestion;
      setQuestions(updatedQuestions);
      setEditIndex(null);
    } else {
      setQuestions([...questions, currentQuestion]);
    }

    setCurrentQuestion({
      question: "",
      marks: 0,
      image: null,
      options: ["", ""],
      correctAnswer: [],
    });
    setShowForm(false);
  };

  const addOption = () => {
    setCurrentQuestion({
      ...currentQuestion,
      options: [...currentQuestion.options, ""],
    });
  };

  const removeOption = (indexToRemove) => {
    if (currentQuestion.options.length <= 2) {
      alert("Minimum 2 options are required");
      return;
    }

    const newOptions = currentQuestion.options.filter(
      (_, index) => index !== indexToRemove
    );
    setCurrentQuestion({
      ...currentQuestion,
      options: newOptions,
      correctAnswer: currentQuestion.correctAnswer
        .filter((ans) => ans !== indexToRemove)
        .map((ans) => (ans > indexToRemove ? ans - 1 : ans)),
    });
  };

  const handleEditQuestion = (index) => {
    setCurrentQuestion(questions[index]);
    setEditIndex(index);
    setShowForm(true);
  };

  const handleDeleteQuestion = (index) => {
    setQuestions(questions.filter((_, i) => i !== index));
  };

  return (
    <>
      <Sidebar />
      <header className="ml-[16.975rem] flex items-center justify-between bg-[#F3F4FF] px-10 py-6">
        <h1 className="text-4xl font-bold text-[#303972]">
          Add MCQ Assessment
        </h1>
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
                  d="M8 7V3m8 4V3m-9 8h10M5 21h14a2 2 0 002-2V7a2 2 0 00-2-2H5a2 2 0 00-2 2v12a2 2 0 002 2z"
                />
              </svg>
            </div>
            <div>
              <h2 className="text-sm font-medium text-gray-500">
                Total Questions
              </h2>
              <p className="text-3xl font-bold text-[#303972]">
                {questions.length}
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
                  d="M11 3.055A9.001 9.001 0 1020.945 13H11V3.055z"
                />
                <path
                  strokeLinecap="round"
                  strokeLinejoin="round"
                  strokeWidth={2}
                  d="M20.488 9H15V3.512A9.025 9.025 0 0120.488 9z"
                />
              </svg>
            </div>
            <div>
              <h2 className="text-sm font-medium text-gray-500">Total Marks</h2>
              <p className="text-3xl font-bold text-[#303972]">
                {questions.reduce((sum, q) => sum + q.marks, 0)}
              </p>
            </div>
          </div>
        </div>
      </div>

      <main className="ml-[16.975rem] min-h-screen bg-[#F3F4FF] p-10">
        <Dialog open={showForm} onOpenChange={setShowForm}>
          <div className="flex justify-between mb-8">
            <DialogTrigger asChild>
              <button className="flex items-center gap-2 rounded-xl bg-[#303972] px-6 py-3 text-white hover:bg-[#252d5a] transition-colors duration-200 shadow-md hover:shadow-lg">
                <PlusCircleIcon className="h-5 w-5" />
                <span className="font-medium">Add Question</span>
              </button>
            </DialogTrigger>

            {questions.length > 0 && (
              <Link to="/teacher/assessments">
                <button className="flex items-center gap-2 rounded-xl bg-green-600 px-6 py-3 text-white hover:bg-green-700 transition-colors duration-200 shadow-md hover:shadow-lg">
                  <svg
                    xmlns="http://www.w3.org/2000/svg"
                    className="h-5 w-5"
                    fill="none"
                    viewBox="0 0 24 24"
                    stroke="currentColor"
                  >
                    <path
                      strokeLinecap="round"
                      strokeLinejoin="round"
                      strokeWidth={2}
                      d="M5 13l4 4L19 7"
                    />
                  </svg>
                  <span className="font-medium">Complete Assessment</span>
                </button>
              </Link>
            )}
          </div>

          <DialogContent className="max-w-2xl max-h-[85vh] overflow-y-auto">
            <DialogHeader>
              <DialogTitle>
                {editIndex !== null ? "Edit Question" : "Add New Question"}
              </DialogTitle>
            </DialogHeader>

            <div className="space-y-4 py-4">
              {/* Question field */}
              <div>
                <label className="block text-sm font-medium">Question</label>
                <textarea
                  className="mt-1 block w-full rounded-md border p-2"
                  value={currentQuestion.question}
                  onChange={(e) =>
                    setCurrentQuestion({
                      ...currentQuestion,
                      question: e.target.value,
                    })
                  }
                />
              </div>

              <div>
                <label className="block text-sm font-medium">Marks</label>
                <input
                  type="number"
                  className="mt-1 block w-32 rounded-md border p-2"
                  value={currentQuestion.marks}
                  onChange={(e) =>
                    setCurrentQuestion({
                      ...currentQuestion,
                      marks: parseInt(e.target.value),
                    })
                  }
                />
              </div>

              <div>
                <label className="block text-sm font-medium">
                  Image (optional)
                </label>
                <input
                  type="file"
                  accept="image/*"
                  className="mt-1 block w-full"
                  onChange={(e) => {
                    const file = e.target.files[0];
                    if (file) {
                      const reader = new FileReader();
                      reader.onloadend = () => {
                        setCurrentQuestion({
                          ...currentQuestion,
                          image: reader.result,
                        });
                      };
                      reader.readAsDataURL(file);
                    }
                  }}
                />
              </div>

              <div>
                <label className="block text-sm font-medium">Options</label>
                {currentQuestion.options.map((option, index) => (
                  <div key={index} className="mt-2 flex items-center gap-2">
                    <input
                      type="text"
                      className="flex-1 rounded-md border p-2"
                      value={option}
                      onChange={(e) => {
                        const newOptions = [...currentQuestion.options];
                        newOptions[index] = e.target.value;
                        setCurrentQuestion({
                          ...currentQuestion,
                          options: newOptions,
                        });
                      }}
                    />
                    <input
                      type="checkbox"
                      checked={currentQuestion.correctAnswer.includes(index)}
                      onChange={(e) => {
                        setCurrentQuestion({
                          ...currentQuestion,
                          correctAnswer: e.target.checked
                            ? [...currentQuestion.correctAnswer, index]
                            : currentQuestion.correctAnswer.filter(
                                (i) => i !== index
                              ),
                        });
                      }}
                    />
                    {currentQuestion.options.length > 2 && (
                      <X
                        className="h-5 w-5 cursor-pointer text-red-500"
                        onClick={() => removeOption(index)}
                      />
                    )}
                  </div>
                ))}
                <button
                  type="button"
                  onClick={addOption}
                  className="mt-2 rounded-md border border-[#303972] px-3 py-1 text-sm text-[#303972]"
                >
                  Add Option
                </button>
              </div>

              <div className="flex gap-4 pt-4">
                <button
                  onClick={handleAddQuestion}
                  className="rounded-md bg-[#303972] px-4 py-2 text-white"
                >
                  {editIndex !== null ? "Update Question" : "Add Question"}
                </button>
                <button
                  onClick={() => {
                    setShowForm(false);
                    setEditIndex(null);
                    setCurrentQuestion({
                      question: "",
                      marks: 0,
                      image: null,
                      options: ["", "", "", ""],
                      correctAnswer: [],
                    });
                  }}
                  className="rounded-md border border-[#303972] px-4 py-2 text-[#303972]"
                >
                  Cancel
                </button>
              </div>
            </div>
          </DialogContent>
        </Dialog>

        <Dialog open={!!error} onOpenChange={() => setError("")}>
          <DialogContent className="bg-red-100 border border-red-400 text-red-700">
            <DialogHeader>
              <DialogTitle>Error</DialogTitle>
            </DialogHeader>
            <p>{error}</p>
          </DialogContent>
        </Dialog>

        {/* Update the question cards style */}
        <div className="mb-8 grid gap-6">
          {questions.map((q, index) => (
            <div
              key={index}
              className="rounded-xl bg-white p-6 shadow-md hover:shadow-lg transition-shadow duration-200"
            >
              <div className="flex justify-between items-center mb-4">
                <h3 className="text-xl font-semibold text-[#303972]">
                  Question {index + 1}
                </h3>
                <div className="flex gap-3">
                  <button
                    onClick={() => handleEditQuestion(index)}
                    className="p-2 hover:bg-blue-50 rounded-lg transition-colors duration-200"
                  >
                    <PencilIcon className="h-5 w-5 text-blue-600" />
                  </button>
                  <button
                    onClick={() => handleDeleteQuestion(index)}
                    className="p-2 hover:bg-red-50 rounded-lg transition-colors duration-200"
                  >
                    <TrashIcon className="h-5 w-5 text-red-600" />
                  </button>
                </div>
              </div>
              <p className="my-2">{q.question}</p>
              {q.image && (
                <img src={q.image} alt="question" className="my-2 max-h-40" />
              )}
              <div className="ml-4 space-y-2">
                {q.options.map((option, optIndex) => (
                  <div
                    key={optIndex}
                    className={`p-2 rounded ${
                      q.correctAnswer.includes(optIndex) ? "bg-green-100" : ""
                    }`}
                  >
                    {option}
                  </div>
                ))}
              </div>
              <div className="mt-2 text-sm text-gray-600">Marks: {q.marks}</div>
            </div>
          ))}
        </div>
      </main>
    </>
  );
}

export default AddMCQPage;
