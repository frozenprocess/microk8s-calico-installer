# Calico Installer

This bash script installs Calico on MicroK8S

# Important

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

# How to use

In order to use this script run following command in your master node.

```
git clone https://github.com/frozenprocess/microk8s-calico-installer.git
cd microk8s-calico-installer
sudo chmod +x calico.sh && sudo ./calico.sh master
```

For additional nodes run following command

```
git clone https://github.com/frozenprocess/microk8s-calico-installer.git
cd microk8s-calico-installer
sudo chmod +x calico.sh && sudo ./calico.sh
```