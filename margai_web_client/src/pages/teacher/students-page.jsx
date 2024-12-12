import { useState } from "react";
import Header from "@/components/teacher/Header";
import Sidebar from "@/components/teacher/Sidebar";
import { mockClasses, mockStudents } from "@/data/data";

function StudentsPage() {
  const [selectedClass, setSelectedClass] = useState("");
  const [students, setStudents] = useState([]);
  const [sortConfig, setSortConfig] = useState({
    key: null,
    direction: "ascending",
  });
  const [selectedStudent, setSelectedStudent] = useState(null);

  const handleClassChange = (e) => {
    const selectedClass = e.target.value;
    setSelectedClass(selectedClass);
    setStudents(mockStudents[selectedClass] || []);
  };

  const handleSort = (key) => {
    let direction = "ascending";
    if (sortConfig.key === key && sortConfig.direction === "ascending") {
      direction = "descending";
    }
    setSortConfig({ key, direction });
  };

  const sortedStudents = [...students].sort((a, b) => {
    if (a[sortConfig.key] < b[sortConfig.key]) {
      return sortConfig.direction === "ascending" ? -1 : 1;
    }
    if (a[sortConfig.key] > b[sortConfig.key]) {
      return sortConfig.direction === "ascending" ? 1 : -1;
    }
    return 0;
  });

  const handleStudentClick = (student) => {
    setSelectedStudent(student);
  };

  return (
    <>
      <Sidebar />
      <div className="ml-[16.975rem] h-screen bg-[#F3F4FF] mb-20">
        <Header title="Students" />
        <div className="p-10 pt-0">
          <div className="w-full">
            <div className="mt-6">
              <label className="block text-sm font-medium text-[#303972] mb-2">
                Select Class
              </label>
              <select
                className="block w-full p-2.5 border border-gray-300 rounded-lg focus:ring-2 focus:ring-[#303972] focus:border-transparent transition-all duration-200"
                value={selectedClass}
                onChange={handleClassChange}
              >
                <option value="">Select a class</option>
                {mockClasses.map((className) => (
                  <option key={className} value={className}>
                    {className}
                  </option>
                ))}
              </select>
            </div>

            {students.length > 0 && (
              <div className="mt-8">
                <table className="min-w-full bg-white rounded-lg shadow-md">
                  <thead>
                    <tr>
                      <th
                        className="py-2 px-4 border-b cursor-pointer"
                        onClick={() => handleSort("name")}
                      >
                        Student Name
                      </th>
                      <th
                        className="py-2 px-4 border-b cursor-pointer"
                        onClick={() => handleSort("courses")}
                      >
                        Courses
                      </th>
                      <th
                        className="py-2 px-4 border-b cursor-pointer"
                        onClick={() => handleSort("enrollmentNo")}
                      >
                        Enrollment No.
                      </th>
                      <th
                        className="py-2 px-4 border-b cursor-pointer"
                        onClick={() => handleSort("attendance")}
                      >
                        Attendance (%)
                      </th>
                    </tr>
                  </thead>
                  <tbody>
                    {sortedStudents.map((student, index) => (
                      <tr
                        key={index}
                        className="text-center cursor-pointer"
                        onClick={() => handleStudentClick(student)}
                      >
                        <td className="py-2 px-4 border-b">{student.name}</td>
                        <td className="py-2 px-4 border-b">
                          {student.courses}
                        </td>
                        <td className="py-2 px-4 border-b">
                          {student.enrollmentNo}
                        </td>
                        <td className="py-2 px-4 border-b">
                          {student.attendance}
                        </td>
                      </tr>
                    ))}
                  </tbody>
                </table>
              </div>
            )}

            {selectedStudent && (
              <div className="mt-8 bg-white p-6 rounded-lg shadow-md">
                <h2 className="text-xl font-bold mb-4">Student Report</h2>
                <div className="grid grid-cols-2 gap-8">
                  <div>
                    <h3 className="font-semibold mb-2">Basic Information</h3>
                    <p>
                      <strong>Name:</strong> {selectedStudent.name}
                    </p>
                    <p>
                      <strong>Enrollment No:</strong>{" "}
                      {selectedStudent.enrollmentNo}
                    </p>
                    <p>
                      <strong>Class:</strong> {selectedClass}
                    </p>

                    <h3 className="font-semibold mt-4 mb-2">
                      Academic Performance
                    </h3>
                    <div className="grid grid-cols-2 gap-4">
                      <div>
                        <p>
                          <strong>Assignments:</strong>{" "}
                          {selectedStudent.performance.assignments}%
                        </p>
                        <p>
                          <strong>Quizzes:</strong>{" "}
                          {selectedStudent.performance.quizzes}%
                        </p>
                      </div>
                      <div>
                        <p>
                          <strong>Participation:</strong>{" "}
                          {selectedStudent.performance.participation}%
                        </p>
                        <p>
                          <strong>Projects:</strong>{" "}
                          {selectedStudent.performance.projects}%
                        </p>
                      </div>
                    </div>
                  </div>

                  <div>
                    <h3 className="font-semibold mb-2">Exam Results</h3>
                    <table className="min-w-full bg-white rounded-lg shadow-md">
                      <thead>
                        <tr>
                          <th className="py-2 px-4 border-b">Exam</th>
                          <th className="py-2 px-4 border-b">Course</th>
                          <th className="py-2 px-4 border-b">Score</th>
                          <th className="py-2 px-4 border-b">Status</th>
                        </tr>
                      </thead>
                      <tbody>
                        {selectedStudent.results.map((result, index) => (
                          <tr key={index} className="text-center">
                            <td className="py-2 px-4 border-b">
                              {result.examName}
                            </td>
                            <td className="py-2 px-4 border-b">
                              {result.course}
                            </td>
                            <td className="py-2 px-4 border-b">
                              {result.score}%
                            </td>
                            <td className="py-2 px-4 border-b">
                              {result.status}
                            </td>
                          </tr>
                        ))}
                      </tbody>
                    </table>

                    <div className="mt-4">
                      <p>
                        <strong>Teacher Remarks:</strong>{" "}
                        {selectedStudent.remarks}
                      </p>
                      <p>
                        <strong>Overall Status:</strong>{" "}
                        {selectedStudent.overallStatus}
                      </p>
                    </div>
                  </div>
                </div>
              </div>
            )}
          </div>
        </div>
      </div>
    </>
  );
}

export default StudentsPage;
