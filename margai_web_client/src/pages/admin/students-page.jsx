import { useState } from "react";
import Header from "@/components/admin/Header";
import Sidebar from "@/components/admin/Sidebar";
import {
  Table,
  TableBody,
  TableCell,
  TableHead,
  TableHeader,
  TableRow,
} from "@/components/ui/table";
import { Button } from "@/components/ui/button";
import {
  Drawer,
  DrawerContent,
  DrawerHeader,
  DrawerTitle,
  DrawerTrigger,
} from "@/components/ui/drawer";
import { Input } from "@/components/ui/input";
import { Label } from "@/components/ui/label";
import {
  Select,
  SelectContent,
  SelectItem,
  SelectTrigger,
  SelectValue,
} from "@/components/ui/select";

const mockClasses = ["Class A", "Class B", "Class C"];

function StudentsPage() {
  const [students, setStudents] = useState([
    {
      id: 1,
      name: "John Doe",
      email: "john@example.com",
      accessibility: "Voice-to-text",
      class: "Class A",
    },
  ]);

  const [isDrawerOpen, setIsDrawerOpen] = useState(false);
  const [newStudent, setNewStudent] = useState({
    email: "",
    class: "",
    password: "",
  });

  const handleAddStudent = (e) => {
    e.preventDefault();
    // Add validation and API call here
    setStudents([...students, { ...newStudent, id: students.length + 1 }]);
    setNewStudent({ email: "", class: "", password: "" });
    setIsDrawerOpen(false);
  };

  return (
    <div className="h-screen">
      <Sidebar />
      <Header heading="Students" />
      <div className="ml-[16.975rem] bg-[#E8F9F9] h-full pb-8 flex-1 p-8">
        <div className="flex justify-between items-center mb-6">
          <h2 className="text-2xl font-bold">Students List</h2>
          <Drawer open={isDrawerOpen} onOpenChange={setIsDrawerOpen}>
            <DrawerTrigger asChild>
              <Button>Add New Student</Button>
            </DrawerTrigger>
            <DrawerContent>
              <DrawerHeader>
                <DrawerTitle>Invite New Student</DrawerTitle>
              </DrawerHeader>
              <form onSubmit={handleAddStudent} className="p-6 space-y-4">
                <div>
                  <Label htmlFor="email">Email</Label>
                  <Input
                    id="email"
                    type="email"
                    value={newStudent.email}
                    onChange={(e) =>
                      setNewStudent({ ...newStudent, email: e.target.value })
                    }
                    required
                  />
                </div>
                <div>
                  <Label htmlFor="class">Class</Label>
                  <Select
                    value={newStudent.class}
                    onValueChange={(value) =>
                      setNewStudent({ ...newStudent, class: value })
                    }
                  >
                    <SelectTrigger>
                      <SelectValue placeholder="Select class" />
                    </SelectTrigger>
                    <SelectContent>
                      {mockClasses.map((className) => (
                        <SelectItem key={className} value={className}>
                          {className}
                        </SelectItem>
                      ))}
                    </SelectContent>
                  </Select>
                </div>
                <div>
                  <Label htmlFor="password">Temporary Password</Label>
                  <Input
                    id="password"
                    type="password"
                    value={newStudent.password}
                    onChange={(e) =>
                      setNewStudent({ ...newStudent, password: e.target.value })
                    }
                    required
                  />
                </div>
                <Button type="submit" className="w-full">
                  Send Invite
                </Button>
              </form>
            </DrawerContent>
          </Drawer>
        </div>

        <div className="rounded-md border">
          <Table>
            <TableHeader>
              <TableRow>
                <TableHead>Name</TableHead>
                <TableHead>Email</TableHead>
                <TableHead>Accessibility Setting</TableHead>
                <TableHead>Class</TableHead>
              </TableRow>
            </TableHeader>
            <TableBody>
              {students.map((student) => (
                <TableRow key={student.id}>
                  <TableCell>{student.name}</TableCell>
                  <TableCell>{student.email}</TableCell>
                  <TableCell>{student.accessibility}</TableCell>
                  <TableCell>{student.class}</TableCell>
                </TableRow>
              ))}
            </TableBody>
          </Table>
        </div>
      </div>
    </div>
  );
}

export default StudentsPage;
