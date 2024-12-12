import { useState } from "react";
import Sidebar from "@/components/admin/Sidebar";
import Header from "@/components/admin/Header";
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

function TeachersPage() {
  const [teachers, setTeachers] = useState([
    {
      id: 1,
      name: "Alice Johnson",
      email: "alice@example.com",
      subject: "Math",
      contact: "123-456-7890",
    },
  ]);

  const [isDrawerOpen, setIsDrawerOpen] = useState(false);
  const [newTeacher, setNewTeacher] = useState({
    name: "",
    email: "",
    subject: "",
    address: "",
    contact: "",
  });

  const handleAddTeacher = (e) => {
    e.preventDefault();
    // Add validation and API call here
    setTeachers([...teachers, { ...newTeacher, id: teachers.length + 1 }]);
    setNewTeacher({
      name: "",
      email: "",
      subject: "",
      address: "",
      contact: "",
    });
    setIsDrawerOpen(false);
  };

  return (
    <div className="h-screen">
      <Sidebar />
      <Header heading="Teachers" />
      <div className="ml-[16.975rem] bg-[#E8F9F9] h-full pb-8 flex-1 p-8">
        <div className="flex justify-between items-center mb-6">
          <h2 className="text-2xl font-bold">Teachers List</h2>
          <Drawer open={isDrawerOpen} onOpenChange={setIsDrawerOpen}>
            <DrawerTrigger asChild>
              <Button>Add New Teacher</Button>
            </DrawerTrigger>
            <DrawerContent>
              <DrawerHeader>
                <DrawerTitle>Add New Teacher</DrawerTitle>
              </DrawerHeader>
              <form onSubmit={handleAddTeacher} className="p-6 space-y-4">
                <div>
                  <Label htmlFor="name">Name</Label>
                  <Input
                    id="name"
                    type="text"
                    value={newTeacher.name}
                    onChange={(e) =>
                      setNewTeacher({ ...newTeacher, name: e.target.value })
                    }
                    required
                  />
                </div>
                <div>
                  <Label htmlFor="email">Email</Label>
                  <Input
                    id="email"
                    type="email"
                    value={newTeacher.email}
                    onChange={(e) =>
                      setNewTeacher({ ...newTeacher, email: e.target.value })
                    }
                    required
                  />
                </div>
                <div>
                  <Label htmlFor="subject">Subject</Label>
                  <Input
                    id="subject"
                    type="text"
                    value={newTeacher.subject}
                    onChange={(e) =>
                      setNewTeacher({ ...newTeacher, subject: e.target.value })
                    }
                    required
                  />
                </div>
                <div>
                  <Label htmlFor="address">Address</Label>
                  <Input
                    id="address"
                    type="text"
                    value={newTeacher.address}
                    onChange={(e) =>
                      setNewTeacher({ ...newTeacher, address: e.target.value })
                    }
                  />
                </div>
                <div>
                  <Label htmlFor="contact">Contact</Label>
                  <Input
                    id="contact"
                    type="text"
                    value={newTeacher.contact}
                    onChange={(e) =>
                      setNewTeacher({ ...newTeacher, contact: e.target.value })
                    }
                    required
                  />
                </div>
                <Button type="submit" className="w-full">
                  Add Teacher
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
                <TableHead>Subject</TableHead>
                <TableHead>Contact</TableHead>
              </TableRow>
            </TableHeader>
            <TableBody>
              {teachers.map((teacher) => (
                <TableRow key={teacher.id}>
                  <TableCell>{teacher.name}</TableCell>
                  <TableCell>{teacher.email}</TableCell>
                  <TableCell>{teacher.subject}</TableCell>
                  <TableCell>{teacher.contact}</TableCell>
                </TableRow>
              ))}
            </TableBody>
          </Table>
        </div>
      </div>
    </div>
  );
}

export default TeachersPage;
