import json
import os
import glob
import pprint
import subprocess
from shutil import which


class Test:
	count = 0


	def __init__(self,prg):
		self.prg = prg

	def dut(self,filename):
		self.count += 1
		try:
			with open(filename) as f:
				data = json.load(f)				
				
				if "path" not in data:
					data["path"] = os.path.dirname(filename)
				
				compiled_resource = self.prg.compile(data)
				if compiled_resource["status"]:
					test_result = subprocess.run(compiled_resource["exec"], check=True, stdout=subprocess.PIPE, universal_newlines=True)
					if test_result.stdout == data["expect"]:
						self.handle_passed(filename)
					else:
						self.handle_failed(filename)
						
		except Exception as error:
			self.handle_error(filename)
			print("\t" + str(error))


	
	def handle_error(self,filename):
		print("[%d] [ERROR] %s." % (self.count,filename))
	
	def handle_passed(self,filename):
		print("[%d] [PASSED] %s." % (self.count,filename))

	def handle_failed(self,filename):
		print("[%d] [FAILED] %s." % (self.count,filename))



class IVerilog:
	
	def __init__(self,include_paths):
		self.include_paths = include_paths
		self.prg = which("iverilog")
		if self.prg == None:
			raise ("Could not locate iverilog executable")		
		
	def info(self):
		return [ self.include_paths, self.prg]


	def compile(self,data):
		exec = os.path.join(data["path"],"conjure.out")
		args = [self.prg, "-o"+exec]

		if "src" in data:
			args.append(os.path.join(data["path"],data["src"]))

		return {"status" : subprocess.call(args) == 0, "exec": os.path.join(data["path"],"conjure.out")}

		
		

def main():
	incl_paths = []
	if os.environ.get('CONJURE_PATH') != None:
		incl_paths.append(os.environ.get('CONJURE_PATH') + "/rtl")

	prog = IVerilog(incl_paths)
	test = Test(prog);
	path = os.getcwd()
	#print(prog.info())
	for filename in glob.glob('./**/*.json',recursive=True):
		test.dut(os.path.abspath(filename))
 
  
if __name__== "__main__":
  main()
